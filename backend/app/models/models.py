# coding: utf-8
from sqlalchemy import BINARY, CheckConstraint, Column, Computed, DECIMAL, Date, DateTime, Enum, ForeignKey, Index, Integer, SmallInteger, String, TIMESTAMP, Text, Time, VARBINARY, text, JSON
from sqlalchemy.dialects.mysql import ENUM, TINYINT
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from app.db.database import Base
from enum import Enum as PyEnum
from sqlalchemy.sql import func



Base = declarative_base()
metadata = Base.metadata


class PasswordResetToken(Base):
    __tablename__ = 'PasswordResetToken'
    __table_args__ = (
        Index('idx_status_expires', 'status', 'expires_at'),
    )

    prt_id = Column(Integer, primary_key=True)
    token = Column(BINARY(32), nullable=False, unique=True)
    expires_at = Column(TIMESTAMP, nullable=False)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    used_at = Column(TIMESTAMP)
    ip_address = Column(VARBINARY(16))
    status = Column(Enum('active', 'expired', 'used'), server_default=text("'active'"))
    is_deleted = Column(TINYINT(1), server_default=text("'0'"))


class AcademyFeaturedListingPackage(Base):
    __tablename__ = 'academy_featured_listing_packages'
    __table_args__ = (
        CheckConstraint('(`num_featured_listings` > 0)'),
        CheckConstraint('(`price` >= 0)')
    )

    package_id = Column(Integer, primary_key=True)
    package_name = Column(String(100), nullable=False, unique=True)
    num_featured_listings = Column(Integer, nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False, index=True)
    status = Column(Enum('active', 'inactive'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class AcademyPushNotificationPackage(Base):
    __tablename__ = 'academy_push_notification_packages'
    __table_args__ = (
        CheckConstraint('(`num_notifications` > 0)'),
        CheckConstraint('(`price` >= 0)')
    )

    package_id = Column(Integer, primary_key=True)
    package_name = Column(String(100), nullable=False, unique=True)
    num_notifications = Column(Integer, nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False, index=True)
    status = Column(Enum('active', 'inactive'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class AcademySubscriptionTier(Base):
    __tablename__ = 'academy_subscription_tiers'
    __table_args__ = (
        CheckConstraint('(`free_featured_listings` >= 0)'),
        CheckConstraint('(`free_push_notifications` >= 0)'),
        CheckConstraint('(`monthly_fee` >= 0)')
    )

    tier_id = Column(Integer, primary_key=True)
    plan_name = Column(Enum('bronze', 'silver', 'gold'), nullable=False)
    monthly_fee = Column(DECIMAL(10, 2), nullable=False, index=True)
    features = Column(Text)
    free_push_notifications = Column(Integer, server_default=text("'0'"))
    free_featured_listings = Column(Integer, server_default=text("'0'"))
    status = Column(Enum('active', 'inactive'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class Addres(Base):
    __tablename__ = 'address'
    __table_args__ = (
        Index('idx_city_governorate', 'city', 'governorate'),
    )

    address_id = Column(Integer, primary_key=True)
    listing_id = Column(ForeignKey('listing.listing_id'), index=True)
    address = Column(String(100), nullable=False)
    city = Column(String(50), nullable=False)
    governorate = Column(String(50))
    postal_code = Column(String(10), index=True)
    landmark = Column(String(50), index=True)
    google_maps_link = Column(String(255), index=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    listing = relationship('Listing', primaryjoin='Addres.listing_id == Listing.listing_id')



class CommissionRate(Base):
    __tablename__ = 'commission_rates'
    __table_args__ = (
        CheckConstraint('((`customer_fee_rate` >= 0) and (`customer_fee_rate` <= 100))'),
        CheckConstraint('((`default_rate` >= 0) and (`default_rate` <= 100))'),
        Index('idx_active_dates', 'active_from', 'active_to'),
        Index('idx_vendor_user_type_status', 'vendor_id', 'user_type', 'status'),
        Index('idx_user_type_status', 'user_type', 'status')
    )

    rate_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), index=True)
    vendor_id = Column(ForeignKey('vendors.vendor_id', ondelete='CASCADE'))
    user_type = Column(Enum('coach', 'academy', 'event_organizer'), nullable=False)
    default_rate = Column(DECIMAL(4, 2), nullable=False)
    customer_fee_rate = Column(DECIMAL(4, 2), nullable=False)
    active_from = Column(Date, nullable=False)
    active_to = Column(Date)
    status = Column(Enum('active', 'inactive'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    user = relationship('User')
    vendor = relationship('Vendor', primaryjoin='CommissionRate.vendor_id == Vendor.vendor_id')


class EventType(Base):
    __tablename__ = 'event_type'

    event_type_id = Column(Integer, primary_key=True)
    type = Column(String(50), nullable=False, unique=True)
    status = Column(Enum('active', 'inactive', 'archived'), index=True, server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class FeaturedListingTier(Base):
    __tablename__ = 'featured_listing_tiers'
    __table_args__ = (
        CheckConstraint('((`visibility_percentage` >= 0) and (`visibility_percentage` <= 1))'),
        CheckConstraint('(`monthly_price` >= 0)')
    )

    tier_id = Column(Integer, primary_key=True)
    tier_name = Column(Enum('BRONZE', 'SILVER', 'GOLD', 'HOMEPAGE'), nullable=False, unique=True)
    monthly_price = Column(DECIMAL(10, 2), nullable=False, index=True)
    visibility_percentage = Column(DECIMAL(5, 2), nullable=False, index=True)
    benefits = Column(Text)
    status = Column(Enum('active', 'inactive'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class Listing(Base):
    __tablename__ = 'listing'
    __table_args__ = (
        CheckConstraint('(`current_students` >= 0)'),
        CheckConstraint('(`group_duration` > 0)'),
        CheckConstraint('(`group_price` >= 0)'),
        CheckConstraint('(`individual_duration` > 0)'),
        CheckConstraint('(`individual_price` >= 0)'),
        CheckConstraint('(`min_students` >= 0)'),
        Index('idx_coach_status', 'coach_id', 'status'),
        Index('idx_main_filter', 'type', 'status', 'age_group', 'skill_level'),
        Index('idx_prices', 'individual_price', 'group_price')
    )

    listing_id = Column(Integer, primary_key=True)
    title = Column(String(100), nullable=False)
    coach_id = Column(ForeignKey('coach.coach_id', ondelete='CASCADE'), ForeignKey('coach.coach_id'), nullable=False)
    type = Column(Enum('swimming', 'fitness'), nullable=False)
    description = Column(Text)
    session_type = Column(Enum('individual', 'group'), nullable=False)
    status = Column(Enum('active', 'inactive', 'suspended'), nullable=False, server_default=text("'active'"))
    individual_price = Column(Integer, server_default=text("'0'"))
    individual_duration = Column(Integer, server_default=text("'60'"))
    group_price = Column(Integer, server_default=text("'0'"))
    group_duration = Column(Integer, server_default=text("'60'"))
    min_students = Column(Integer, server_default=text("'0'"))
    max_students = Column(Integer, server_default=text("'10'"))
    current_students = Column(Integer, server_default=text("'0'"))
    age_group = Column(String(50), nullable=False)
    skill_level = Column(Enum('beginner', 'intermediate', 'advanced'), nullable=False)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    address_id = Column(ForeignKey('address.address_id', ondelete='CASCADE'), nullable=False, index=True)

    address = relationship('Addres', primaryjoin='Listing.address_id == Addres.address_id')
    coach = relationship('Coach', primaryjoin='Listing.coach_id == Coach.coach_id')
    


class MarketplaceCategory(Base):
    __tablename__ = 'marketplace_categories'

    category_id = Column(Integer, primary_key=True)
    name = Column(String(100, 'utf8mb4_general_ci'), nullable=False, unique=True)
    description = Column(Text(collation='utf8mb4_general_ci'))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))


class Partnership(Base):
    __tablename__ = 'partnerships'

    partnership_id = Column(Integer, primary_key=True)
    partner_name = Column(String(255), nullable=False, index=True)
    contact_info = Column(Text, nullable=False)
    description = Column(Text)
    start_date = Column(Date, nullable=False, index=True)
    end_date = Column(Date, nullable=False)


class PushNotificationPackage(Base):
    __tablename__ = 'push_notification_packages'
    __table_args__ = (
        CheckConstraint('(`num_notifications` > 0)'),
        CheckConstraint('(`price` >= 0)')
    )

    package_id = Column(Integer, primary_key=True)
    package_name = Column(String(50), nullable=False, unique=True)
    num_notifications = Column(Integer, nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False, index=True)
    status = Column(Enum('active', 'inactive'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class PushNotificationTier(Base):
    __tablename__ = 'push_notification_tiers'
    __table_args__ = (
        CheckConstraint('((`reach_percentage` >= 0) and (`reach_percentage` <= 1))'),
        CheckConstraint('(`price` >= 0)')
    )

    tier_id = Column(Integer, primary_key=True)
    tier_name = Column(Enum('gold', 'silver', 'bronze'), nullable=False, unique=True)
    price = Column(DECIMAL(10, 2), nullable=False, index=True)
    reach_percentage = Column(DECIMAL(5, 2), nullable=False)
    targeting_level = Column(Enum('basic', 'better', 'full'), nullable=False)
    description = Column(Text)
    status = Column(Enum('active', 'inactive'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class SubscriptionTier(Base):
    __tablename__ = 'subscription_tiers'
    __table_args__ = (
        CheckConstraint('(`commission_rate` >= 0)'),
        CheckConstraint('(`free_push_notifications` >= 0)'),
        CheckConstraint('(`monthly_fee` >= 0)')
    )

    tier_id = Column(Integer, primary_key=True)
    plan_name = Column(Enum('bronze', 'silver', 'gold'), nullable=False, unique=True)
    monthly_fee = Column(DECIMAL(10, 2), nullable=False)
    commission_rate = Column(DECIMAL(5, 2), nullable=False)
    features = Column(Text)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    free_push_notifications = Column(Integer, server_default=text("'0'"))
    description = Column(Text)


class User(Base):
    __tablename__ = 'user'
    __table_args__ = (
        Index('idx_name_email', 'name', 'email'),
        Index('idx_user_type_status', 'user_type', 'account_status')
    )

    user_id = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=False, index=True)
    email = Column(String(50), nullable=False, unique=True)
    prefered_language = Column(Enum('ar', 'en'), server_default=text("'en'"))
    gender = Column(Enum('male', 'female'))
    date_of_birth = Column(Date)
    password_hash = Column(String(128), nullable=False)
    user_type = Column(Enum('swimmer_or_parent', 'coach', 'academy', 'club', 'event_organizer'), nullable=False)
    ban_reason = Column(String(100))
    user_name = Column(String(20), nullable=False, unique=True)
    phone_number = Column(String(15))
    profile_photo_url = Column(String(255))
    account_status = Column(Enum('active', 'inactive', 'suspended', 'banned', 'pending', 'disabled'), nullable=False, server_default=text("'active'"))
    main_location = Column(String(20))
    work_locations = Column(String(100))
    verified_at = Column(DateTime)
    verification_status = Column(Enum('unverified', 'pending', 'verified', 'rejected'), nullable=False, server_default=text("'unverified'"))
    last_login_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    deleted_at = Column(TIMESTAMP)
    verification_token = Column(String(255))
    token_expiry = Column(DateTime)
    email_verified = Column(TINYINT, server_default=text("'0'"))
    role = Column(Enum('swimmer or parent', 'coach', 'academy', 'event_organizer', 'support agent', 'admin'), nullable=False, server_default=text("'swimmer or parent'"))

    emails = relationship("Email", back_populates="user", cascade="all, delete-orphan")



class Vendor(Base):
    __tablename__ = 'vendors'
    __table_args__ = (
        Index('idx_user_status', 'user_id', 'status'),
    )

    vendor_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, unique=True)
    can_ship = Column(TINYINT(1), server_default=text("'0'"))
    description = Column(Text)
    status = Column(Enum('active', 'inactive', 'suspended'), server_default=text("'active'"))
    subscription_status = Column(Enum('active', 'inactive', 'expired'), index=True, server_default=text("'inactive'"))
    commission_rate_id = Column(ForeignKey('commission_rates.rate_id', ondelete='SET NULL'), index=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    commission_rate = relationship('CommissionRate', primaryjoin='Vendor.commission_rate_id == CommissionRate.rate_id')
    user = relationship('User')


class Academy(Base):
    __tablename__ = 'academy'
    __table_args__ = (
        CheckConstraint('((`tax_number` is null) or (length(`tax_number`) > 0))'),
        Index('idx_status_created', 'status', 'created_at'),
        Index('idx_type_user', 'type', 'user_id')
    )

    academy_id = Column(Integer, primary_key=True)
    type = Column(Enum('swimming', 'fitness'), nullable=False)
    user_id = Column(ForeignKey('user.user_id'), nullable=False, index=True)
    description = Column(Text)
    business_license_url = Column(String(255))
    tax_number = Column(String(50), unique=True)
    contact_email = Column(String(50), index=True)
    website_url = Column(String(255))
    logo_url = Column(String(255))
    google_maps_url = Column(String(255))
    status = Column(Enum('active', 'inactive', 'suspended'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    address_id = Column(ForeignKey('address.address_id'), nullable=False, index=True)

    address = relationship('Addres')
    user = relationship('User')


class Achievement(Base):
    __tablename__ = 'achievements'
    __table_args__ = (
        Index('user_id', 'user_id', 'badge_name', unique=True),
    )

    achievement_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False)
    badge_name = Column(String(255), nullable=False)
    type = Column(Enum('milestone', 'performance', 'completion', 'other'), server_default=text("'other'"))
    date_awarded = Column(TIMESTAMP, index=True, server_default=text("CURRENT_TIMESTAMP"))
    description = Column(Text)
    status = Column(Enum('active', 'revoked', 'archived'), index=True, server_default=text("'active'"))
    extra_metadata = Column(Text)

    user = relationship('User')


class ActivityLog(Base):
    __tablename__ = 'activity_logs'

    log_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    timestamp = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    details = Column(Text)
    action = Column(Text, nullable=False)

    user = relationship('User')


class Coach(Base):
    __tablename__ = 'coach'

    coach_id = Column(Integer, primary_key=True)
    type = Column(Enum('swimmer', 'coach'))
    biography = Column(Text)
    years_of_experience = Column(Integer, index=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    specializations = Column(String(100))
    is_verified = Column(TINYINT(1))
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)

    user = relationship('User')


class Event(Base):
    __tablename__ = 'event'
    __table_args__ = (
        Index('idx_event_type_status', 'event_type_id', 'status'),
        Index('idx_event_dates', 'start_date', 'end_date')
    )

    event_id = Column(Integer, primary_key=True)
    title = Column(String(100), nullable=False)
    description = Column(Text)
    max_capacity = Column(Integer)
    current_registration_number = Column(Integer, server_default=text("'0'"))
    price = Column(DECIMAL(10, 2), nullable=False)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=False)
    registration_deadline = Column(DateTime, nullable=False)
    age_range = Column(String(50))
    skill_level = Column(Enum('Beginner', 'Intermediate', 'Advanced', 'Professional'))
    status = Column(Enum('scheduled', 'completed', 'canceled', 'postponed', 'archived'), index=True, server_default=text("'scheduled'"))
    duration = Column(Integer, Computed('(timestampdiff(MINUTE,`start_date`,`end_date`))', persisted=True))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    event_type_id = Column(ForeignKey('event_type.event_type_id', ondelete='SET NULL'))
    organizer_id = Column(Integer, nullable=False)
    address_id = Column(ForeignKey('address.address_id', ondelete='CASCADE'), nullable=False, index=True)

    address = relationship('Addres')
    event_type = relationship('EventType')


class EventOrganizer(Base):
    __tablename__ = 'event_organizer'

    organizer_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, unique=True)
    business_license_url = Column(String(255))
    tax_number = Column(String(50))
    logo_url = Column(String(255))
    status = Column(Enum('active', 'inactive', 'suspended'), index=True, server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    user = relationship('User')


class FamilyGroup(Base):
    __tablename__ = 'family_group'

    group_id = Column(Integer, primary_key=True)
    primary_user_id = Column(Integer, ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False)
    name = Column(String(50), nullable=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    # Relationships
    members = relationship('FamilyMember', back_populates='group_relation')  # Ensure this is not defined as a Column


class GroupChat(Base):
    __tablename__ = 'group_chats'
    __table_args__ = (
        Index('idx_listing_created', 'listing_id', 'created_at'),
    )

    group_chat_id = Column(Integer, primary_key=True)
    listing_id = Column(ForeignKey('listing.listing_id', ondelete='CASCADE'), nullable=False, index=True)
    created_at = Column(TIMESTAMP, index=True, server_default=text("CURRENT_TIMESTAMP"))

    listing = relationship('Listing')


class ListingSchedule(Base):
    __tablename__ = 'listing_schedules'
    __table_args__ = (
        Index('idx_day_schedule', 'day_of_week', 'start_time'),
    )

    schedule_id = Column(Integer, primary_key=True)
    listing_id = Column(ForeignKey('listing.listing_id', ondelete='CASCADE'), nullable=False, index=True)
    day_of_week = Column(Enum('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'), nullable=False)
    start_time = Column(Time, nullable=False)
    end_time = Column(Time, nullable=False)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    listing = relationship('Listing')


class MarketingService(Base):
    __tablename__ = 'marketing_services'
    __table_args__ = (
        CheckConstraint('(`price` >= 0)'),
        Index('idx_user_service', 'user_id', 'status')
    )

    mst_id = Column(Integer, primary_key=True)
    service_name = Column(String(100), nullable=False)
    platform = Column(Enum('snapchat', 'instagram', 'facebook', 'twitter', 'tiktok', 'other'), nullable=False)
    description = Column(Text)
    price = Column(Integer, nullable=False)
    status = Column(Enum('active', 'inactive', 'archived'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False)

    user = relationship('User')


class MarketplaceListing(Base):
    __tablename__ = 'marketplace_listings'
    __table_args__ = (
        CheckConstraint('(`price` >= 0)'),
    )

    listing_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    address_id = Column(ForeignKey('address.address_id', ondelete='CASCADE'), nullable=False, index=True)
    category_id = Column(ForeignKey('marketplace_categories.category_id', ondelete='SET NULL'), index=True)
    title = Column(String(255, 'utf8mb4_general_ci'), nullable=False)
    description = Column(Text(collation='utf8mb4_general_ci'))
    price = Column(DECIMAL(10, 2), nullable=False, index=True)
    item_condition = Column(ENUM('new', 'used'), nullable=False)
    shipping_available = Column(TINYINT(1), server_default=text("'0'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    address = relationship('Addres')
    category = relationship('MarketplaceCategory')
    user = relationship('User')


class Notification(Base):
    __tablename__ = 'notifications'
    __table_args__ = (
        Index('idx_user_type_status', 'user_id', 'type', 'status'),
    )

    notification_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False)
    title = Column(String(255))
    message = Column(Text, nullable=False)
    type = Column(Enum('email', 'in_app', 'push', 'sms', 'webhook'), nullable=False)
    priority = Column(Enum('low', 'normal', 'high'), index=True, server_default=text("'normal'"))
    sent_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    delivered_at = Column(TIMESTAMP, index=True)
    status = Column(Enum('sent', 'read', 'failed'), server_default=text("'sent'"))

    user = relationship('User')


class PaymentTransaction(Base):
    __tablename__ = 'payment_transactions'
    __table_args__ = (
        CheckConstraint('(`amount` >= 0)'),
        Index('idx_transaction_date', 'user_id', 'updated_at'),
        Index('idx_payer_payee', 'payer_id', 'payee_id'),
        Index('idx_user_transaction_date', 'user_id', 'transaction_date')
    )

    transaction_id = Column(Integer, primary_key=True)
    payer_id = Column(Integer, nullable=False)
    payee_id = Column(Integer, nullable=False)
    rate_id = Column(Integer, index=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False)
    amount = Column(DECIMAL(10, 2), nullable=False)
    commission_rate = Column(DECIMAL(5, 2), nullable=False, server_default=text("'0.00'"))
    commission_amount = Column(DECIMAL(10, 2), Computed('(((`amount` * `commission_rate`) / 100))', persisted=True))
    net_amount = Column(DECIMAL(10, 2), Computed('((`amount` - `commission_amount`))', persisted=True))
    transaction_type = Column(String(20), nullable=False, index=True)
    payment_method = Column(String(20), nullable=False)
    reference_id = Column(String(50))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    transaction_date = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    status = Column(Enum('completed', 'pending', 'failed', 'refunded'), index=True, server_default=text("'pending'"))

    user = relationship('User')


class Photographer(Base):
    __tablename__ = 'photographer'

    photographer_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, unique=True)
    status = Column(Enum('active', 'inactive', 'suspended'), index=True, server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    deleted_at = Column(TIMESTAMP)

    user = relationship('User')


class SupportAgent(Base):
    __tablename__ = 'support_agent'

    agent_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, unique=True)
    department = Column(ENUM('technical', 'billing', 'general', 'other'), server_default=text("'general'"))
    active = Column(TINYINT(1), index=True, server_default=text("'1'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    user = relationship('User')


class Swimmer(Base):
    __tablename__ = 'swimmer'
    __table_args__ = (
        Index('idx_skill_created', 'skill_level', 'created_at'),
    )

    swimmer_id = Column(Integer, primary_key=True)
    skill_level = Column(Enum('beginner', 'intermediate', 'advanced'), nullable=False, index=True)
    created_at = Column(TIMESTAMP, index=True, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    goals = Column(String(255), index=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)

    user = relationship('User')


class VendorSubscription(Base):
    __tablename__ = 'vendor_subscriptions'
    __table_args__ = (
        CheckConstraint('(`price` >= 0)'),
        Index('idx_vendor_status', 'vendor_id', 'status'),
        Index('idx_subscription_dates', 'start_date', 'end_date')
    )

    subscription_id = Column(Integer, primary_key=True)
    vendor_id = Column(ForeignKey('vendors.vendor_id', ondelete='CASCADE'), nullable=False)
    tier_id = Column(ForeignKey('subscription_tiers.tier_id', ondelete='CASCADE'), nullable=False, index=True)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False)
    status = Column(Enum('active', 'cancelled', 'expired'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    tier = relationship('SubscriptionTier')
    vendor = relationship('Vendor')


class AcademyFeaturedListing(Base):
    __tablename__ = 'academy_featured_listings'
    __table_args__ = (
        CheckConstraint('(`price` >= 0)'),
        Index('idx_academy_featured', 'academy_id', 'status')
    )

    featured_listing_id = Column(Integer, primary_key=True)
    academy_id = Column(ForeignKey('academy.academy_id', ondelete='CASCADE'), nullable=False)
    tier_id = Column(ForeignKey('academy_featured_listing_packages.package_id'), nullable=False, index=True)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False)
    status = Column(Enum('active', 'expired', 'cancelled', 'pending'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    listing_id = Column(ForeignKey('listing.listing_id'), nullable=False, index=True)

    academy = relationship('Academy')
    listing = relationship('Listing')
    tier = relationship('AcademyFeaturedListingPackage')


class AcademyPushNotification(Base):
    __tablename__ = 'academy_push_notifications'
    __table_args__ = (
        CheckConstraint('((`sent_to_percentage` >= 0) and (`sent_to_percentage` <= 100))'),
        Index('idx_academy_notifications', 'academy_id', 'sent_date')
    )

    notification_id = Column(Integer, primary_key=True)
    academy_id = Column(ForeignKey('academy.academy_id', ondelete='CASCADE'), nullable=False)
    tier_id = Column(ForeignKey('academy_push_notification_packages.package_id'), nullable=False, index=True)
    message = Column(Text, nullable=False)
    sent_to_percentage = Column(DECIMAL(5, 2), nullable=False)
    sent_date = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    status = Column(Enum('scheduled', 'sent', 'failed', 'cancelled'), index=True, server_default=text("'scheduled'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    package_id = Column(ForeignKey('academy_push_notification_packages.package_id'), index=True)

    academy = relationship('Academy')
    package = relationship('AcademyPushNotificationPackage', primaryjoin='AcademyPushNotification.package_id == AcademyPushNotificationPackage.package_id')
    tier = relationship('AcademyPushNotificationPackage', primaryjoin='AcademyPushNotification.tier_id == AcademyPushNotificationPackage.package_id')


class AcademySubscription(Base):
    __tablename__ = 'academy_subscriptions'
    __table_args__ = (
        CheckConstraint('(`end_date` > `start_date`)'),
        CheckConstraint('(`free_featured_listings_remaining` >= 0)'),
        CheckConstraint('(`free_push_notifications_remaining` >= 0)'),
        Index('idx_academy_status', 'academy_id', 'status'),
        Index('idx_subscription_dates', 'start_date', 'end_date')
    )

    subscription_id = Column(Integer, primary_key=True)
    academy_id = Column(ForeignKey('academy.academy_id', ondelete='CASCADE'), nullable=False)
    tier_id = Column(ForeignKey('academy_subscription_tiers.tier_id'), nullable=False, index=True)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    free_push_notifications_remaining = Column(Integer, server_default=text("'0'"))
    free_featured_listings_remaining = Column(Integer, server_default=text("'0'"))
    status = Column(Enum('active', 'cancelled', 'expired'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    academy = relationship('Academy')
    tier = relationship('AcademySubscriptionTier')


class Booking(Base):
    __tablename__ = 'bookings'
    __table_args__ = (
        Index('idx_swimmer_bookings', 'swimmer_id', 'status'),
        Index('idx_coach_bookings', 'coach_id', 'status'),
        Index('idx_listing_bookings', 'listing_id', 'status'),
        Index('idx_booking_listing_swimmer_coach', 'listing_id', 'swimmer_id', 'coach_id')
    )

    booking_id = Column(Integer, primary_key=True)
    listing_id = Column(ForeignKey('listing.listing_id', ondelete='CASCADE'), nullable=False)
    swimmer_id = Column(ForeignKey('swimmer.swimmer_id', ondelete='CASCADE'), nullable=False)
    coach_id = Column(ForeignKey('coach.coach_id', ondelete='CASCADE'), nullable=False)
    session_type = Column(Enum('individual', 'group'), nullable=False)
    status = Column(Enum('pending', 'confirmed', 'completed', 'cancelled'), index=True, server_default=text("'pending'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    coach = relationship('Coach')
    listing = relationship('Listing')
    swimmer = relationship('Swimmer')


class CoachCertification(Base):
    __tablename__ = 'coach_certification'
    __table_args__ = (
        Index('idx_coach_created', 'coach_id', 'created_at'),
    )

    certification_id = Column(Integer, primary_key=True)
    coach_id = Column(ForeignKey('coach.coach_id', ondelete='CASCADE'), nullable=False)
    image_url = Column(Text, nullable=False)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))

    coach = relationship('Coach')


class CoachIdentification(Base):
    __tablename__ = 'coach_identification'
    __table_args__ = (
        Index('idx_coach_created', 'coach_id', 'created_at'),
    )

    identification_id = Column(Integer, primary_key=True)
    coach_id = Column(ForeignKey('coach.coach_id', ondelete='CASCADE'), nullable=False)
    image_url = Column(Text, nullable=False)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))

    coach = relationship('Coach')


class CoachSubscription(Base):
    __tablename__ = 'coach_subscriptions'
    __table_args__ = (
        CheckConstraint('(`free_featured_listings_remaining` >= 0)'),
        CheckConstraint('(`free_push_notifications_remaining` >= 0)'),
        Index('idx_subscription_dates', 'start_date', 'end_date'),
        Index('idx_coach_status', 'coach_id', 'status')
    )

    subscription_id = Column(Integer, primary_key=True)
    coach_id = Column(ForeignKey('coach.coach_id', ondelete='CASCADE'), nullable=False)
    subscription_tier_id = Column(ForeignKey('subscription_tiers.tier_id', ondelete='CASCADE'), nullable=False, index=True)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    status = Column(Enum('active', 'cancelled', 'expired'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    free_push_notifications_remaining = Column(Integer, server_default=text("'0'"))
    free_featured_listings_remaining = Column(Integer, server_default=text("'0'"))

    coach = relationship('Coach')
    subscription_tier = relationship('SubscriptionTier')


class EventAttendance(Base):
    __tablename__ = 'event_attendance'
    __table_args__ = (
        Index('idx_event_attendee', 'event_id', 'attendee_id'),
    )

    attendance_id = Column(Integer, primary_key=True)
    event_id = Column(ForeignKey('event.event_id', ondelete='CASCADE'), nullable=False)
    attendee_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    status = Column(ENUM('attended', 'no-show', 'cancelled'), index=True, server_default=text("'attended'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    attendee = relationship('User')
    event = relationship('Event')


class FamilyMember(Base):
    __tablename__ = 'family_member'

    member_id = Column(Integer, primary_key=True)
    group_id = Column(Integer, ForeignKey('family_group.group_id', ondelete='CASCADE'), nullable=False)
    user_id = Column(Integer, ForeignKey('user.user_id', ondelete='SET NULL'), nullable=True)
    relationship_type = Column(Enum('parent', 'child', 'spouse', 'other'), nullable=False)  # Renamed for clarity
    name = Column(String(50), nullable=False)
    date_of_birth = Column(Date, nullable=True)
    gender = Column(Enum('male', 'female'), nullable=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    # Relationships
    group_relation = relationship('FamilyGroup', back_populates='members')  # Ensure there is no Column conflict




class FeaturedListing(Base):
    __tablename__ = 'featured_listings'
    __table_args__ = (
        CheckConstraint('(`end_date` > `start_date`)'),
        CheckConstraint('(`price` >= 0)'),
        Index('idx_coach_featured', 'coach_id', 'status'),
        Index('idx_tier_status', 'tier_id', 'status')
    )

    featured_listing_id = Column(Integer, primary_key=True)
    coach_id = Column(ForeignKey('coach.coach_id'), nullable=False)
    tier_id = Column(ForeignKey('featured_listing_tiers.tier_id'), nullable=False)
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False)
    status = Column(Enum('active', 'expired', 'cancelled', 'pending'), server_default=text("'active'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    listing_id = Column(ForeignKey('listing.listing_id'), nullable=False, index=True)

    coach = relationship('Coach')
    listing = relationship('Listing')
    tier = relationship('FeaturedListingTier')


class GroupChatMessage(Base):
    __tablename__ = 'group_chat_messages'
    __table_args__ = (
        Index('idx_group_chat_sent', 'group_chat_id', 'sent_at'),
    )

    message_id = Column(Integer, primary_key=True)
    group_chat_id = Column(ForeignKey('group_chats.group_chat_id', ondelete='CASCADE'), nullable=False)
    sender_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    message = Column(Text, nullable=False)
    sent_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))

    group_chat = relationship('GroupChat')
    sender = relationship('User')


class GroupChatParticipant(Base):
    __tablename__ = 'group_chat_participants'
    __table_args__ = (
        Index('idx_group_chat_user', 'group_chat_id', 'user_id'),
    )

    participant_id = Column(Integer, primary_key=True)
    group_chat_id = Column(ForeignKey('group_chats.group_chat_id', ondelete='CASCADE'), nullable=False)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    role = Column(Enum('swimmer', 'parent', 'coach'), nullable=False)
    joined_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))

    group_chat = relationship('GroupChat')
    user = relationship('User')


class MarketingServicesPurchase(Base):
    __tablename__ = 'marketing_services_purchases'
    __table_args__ = (
        Index('idx_user_service', 'user_id', 'mst_id'),
        Index('idx_schedule', 'start_date', 'end_date')
    )

    msp_id = Column(Integer, primary_key=True)
    mst_id = Column(ForeignKey('marketing_services.mst_id', ondelete='CASCADE'), nullable=False, index=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False)
    content_url = Column(String(255), nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False)
    status = Column(Enum('pending', 'approved', 'rejected', 'completed', 'cancelled', 'expired'), nullable=False, index=True)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=False)
    posted_at = Column(TIMESTAMP)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    mst = relationship('MarketingService')
    user = relationship('User')


class MarketplaceFavorite(Base):
    __tablename__ = 'marketplace_favorites'

    favorite_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    listing_id = Column(ForeignKey('marketplace_listings.listing_id', ondelete='CASCADE'), nullable=False, index=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))

    listing = relationship('MarketplaceListing')
    user = relationship('User')


class MarketplaceMessage(Base):
    __tablename__ = 'marketplace_messages'

    message_id = Column(Integer, primary_key=True)
    sender_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    receiver_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    listing_id = Column(ForeignKey('marketplace_listings.listing_id', ondelete='CASCADE'), nullable=False, index=True)
    content = Column(Text(collation='utf8mb4_general_ci'), nullable=False)
    sent_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))

    listing = relationship('MarketplaceListing')
    receiver = relationship('User', primaryjoin='MarketplaceMessage.receiver_id == User.user_id')
    sender = relationship('User', primaryjoin='MarketplaceMessage.sender_id == User.user_id')


class Photo(Base):
    __tablename__ = 'photos'
    __table_args__ = (
        CheckConstraint('(`price` >= 0)'),
    )

    photo_id = Column(Integer, primary_key=True)
    event_id = Column(ForeignKey('event.event_id', ondelete='CASCADE'), nullable=False, index=True)
    photographer_id = Column(ForeignKey('photographer.photographer_id', ondelete='SET NULL'), index=True)
    photo_url = Column(String(255), nullable=False)
    thumbnail_url = Column(String(255), nullable=False)
    price = Column(DECIMAL(10, 2), nullable=False, index=True)
    is_sold = Column(Enum('yes', 'no'), server_default=text("'no'"))
    status = Column(Enum('active', 'archived', 'deleted'), index=True, server_default=text("'active'"))
    metadata_ = Column('metadata', Text)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    event = relationship('Event')
    photographer = relationship('Photographer')


class PushNotification(Base):
    __tablename__ = 'push_notifications'
    __table_args__ = (
        CheckConstraint('((`sent_to_percentage` >= 0) and (`sent_to_percentage` <= 1))'),
        CheckConstraint('(`price` >= 0)'),
        Index('idx_coach_notifications', 'coach_id', 'sent_date')
    )

    notification_id = Column(Integer, primary_key=True)
    coach_id = Column(ForeignKey('coach.coach_id'), nullable=False)
    tier_id = Column(ForeignKey('push_notification_tiers.tier_id'), nullable=False, index=True)
    message = Column(Text, nullable=False)
    sent_to_percentage = Column(DECIMAL(5, 2), nullable=False)
    sent_date = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))
    status = Column(Enum('scheduled', 'sent', 'failed'), index=True, server_default=text("'scheduled'"))
    price = Column(DECIMAL(10, 2), server_default=text("'0.00'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    academy_package_id = Column(ForeignKey('academy_push_notification_packages.package_id'), index=True)
    individual_package_id = Column(ForeignKey('push_notification_packages.package_id'), index=True)

    academy_package = relationship('AcademyPushNotificationPackage')
    coach = relationship('Coach')
    individual_package = relationship('PushNotificationPackage')
    tier = relationship('PushNotificationTier')


class SupportRequest(Base):
    __tablename__ = 'support_requests'
    __table_args__ = (
        CheckConstraint('((`resolved_at` is null) or (`resolved_at` > `created_at`))'),
        Index('idx_status_priority', 'status', 'priority')
    )

    ticket_id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    agent_id = Column(ForeignKey('support_agent.agent_id', ondelete='SET NULL'), index=True)
    subject = Column(String(255, 'utf8mb4_general_ci'), nullable=False)
    description = Column(Text(collation='utf8mb4_general_ci'), nullable=False)
    category = Column(ENUM('technical', 'billing', 'general', 'other'), index=True, server_default=text("'other'"))
    priority = Column(ENUM('low', 'medium', 'high', 'urgent'), server_default=text("'medium'"))
    status = Column(ENUM('open', 'closed', 'pending'), server_default=text("'open'"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    resolved_at = Column(TIMESTAMP)

    agent = relationship('SupportAgent')
    user = relationship('User')


class UserNotificationPackage(Base):
    __tablename__ = 'user_notification_packages'
    __table_args__ = (
        CheckConstraint('(`notifications_remaining` >= 0)'),
        Index('idx_coach_package', 'coach_id', 'status')
    )

    user_package_id = Column(Integer, primary_key=True)
    coach_id = Column(ForeignKey('coach.coach_id'), nullable=False)
    package_id = Column(ForeignKey('push_notification_packages.package_id'), nullable=False, index=True)
    purchase_date = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    notifications_remaining = Column(Integer, nullable=False)
    status = Column(Enum('active', 'expired', 'used', 'cancelled'), server_default=text("'active'"))
    expiration_date = Column(Date, index=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    coach = relationship('Coach')
    package = relationship('PushNotificationPackage')


class BookingParticipant(Base):
    __tablename__ = 'booking_participants'
    __table_args__ = (
        Index('idx_booking_participant', 'booking_id', 'member_id'),
    )

    participant_id = Column(Integer, primary_key=True)
    booking_id = Column(ForeignKey('bookings.booking_id', ondelete='CASCADE'), nullable=False)
    member_id = Column(ForeignKey('family_member.member_id', ondelete='CASCADE'), nullable=False, index=True)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))

    booking = relationship('Booking')
    member = relationship('FamilyMember')


class FreeUsageLog(Base):
    __tablename__ = 'free_usage_logs'
    __table_args__ = (
        Index('idx_coach_usage', 'coach_id', 'type', 'usage_date'),
        Index('idx_subscription_type', 'subscription_id', 'type')
    )

    log_id = Column(Integer, primary_key=True)
    coach_id = Column(ForeignKey('coach.coach_id', ondelete='CASCADE'), nullable=False)
    type = Column(Enum('push_notification', 'featured_listing'), nullable=False)
    usage_date = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    subscription_id = Column(ForeignKey('coach_subscriptions.subscription_id', ondelete='CASCADE'), nullable=False)
    details = Column(Text)

    coach = relationship('Coach')
    subscription = relationship('CoachSubscription')


class Review(Base):
    __tablename__ = 'review'
    __table_args__ = (
        CheckConstraint('((`rating` >= 0.0) and (`rating` <= 5.0))'),
    )

    review_id = Column(Integer, primary_key=True)
    reviewer_id = Column(ForeignKey('user.user_id', ondelete='CASCADE'), nullable=False, index=True)
    coach_id = Column(ForeignKey('coach.coach_id', ondelete='CASCADE'), nullable=False, index=True)
    booking_id = Column(ForeignKey('bookings.booking_id', ondelete='CASCADE'), index=True)
    status = Column(ENUM('pending', 'approved', 'rejected', 'hidden'), index=True, server_default=text("'pending'"))
    rating = Column(DECIMAL(2, 1))
    feedback = Column(Text(collation='utf8mb4_general_ci'))
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    is_deleted = Column(TINYINT(1), server_default=text("'0'"))
    reported_count = Column(SmallInteger, server_default=text("'0'"))

    booking = relationship('Booking')
    coach = relationship('Coach')
    reviewer = relationship('User')


class ParticipantDetail(Base):
    __tablename__ = 'participant_details'

    detail_id = Column(Integer, primary_key=True)
    participant_id = Column(ForeignKey('booking_participants.participant_id', ondelete='CASCADE'), nullable=False, index=True)
    skill_level = Column(Enum('Beginner', 'Intermediate', 'Advanced', 'Competitive/Professional'))
    medical_notes = Column(Text)
    special_requirements = Column(Text)
    created_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    updated_at = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    participant = relationship('BookingParticipant')

class Email(Base):
    __tablename__ = "emails"

    email_id = Column(Integer, primary_key=True, autoincrement=True)  # Primary key
    user_id = Column(Integer, ForeignKey("user.user_id"), nullable=False)  # Foreign key to user table
    email = Column(String(255), nullable=False)  # Recipient's email address
    subject = Column(String(255), nullable=False)  # Subject of the email
    body = Column(Text, nullable=False)  # Main content of the email
    attachments = Column(JSON, nullable=True)  # Attachments as JSON
    delivery_time = Column(DateTime, nullable=True)  # Scheduled delivery time
    status = Column(
        String(20), default="pending", nullable=False
    )  # Simplified status field as a String for now
    created_at = Column(
        TIMESTAMP, server_default=func.now(), nullable=False
    )  # Auto-set creation time
    updated_at = Column(
        TIMESTAMP, server_default=func.now(), onupdate=func.now(), nullable=False
    )  # Auto-set update time

    # Relationship to user model
    user = relationship("User", back_populates="emails")

    # Indexes
    __table_args__ = (
        Index("idx_user_status", "user_id", "status"),
        Index("idx_delivery_time", "delivery_time"),
    )