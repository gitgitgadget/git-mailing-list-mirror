X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not use esc_html in esc_path
Date: Sat, 25 Nov 2006 10:54:04 +0100
Message-ID: <200611251054.04295.jnareb@gmail.com>
References: <11644442392444-git-send-email-jnareb@gmail.com> <7v3b876esd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 09:52:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EmwHp9hVvrPHy3XASnkGt5rEiAF7rzc4e4MABwxRGkaF4gBl1Dow4xQnIRTyaNue0lw+dJgBNT8COyc+qBnjFBrTd4KJ+i9nlTnPvRsqXp6oymK8zVik0r6mbd0XKLxhGf00rAdwJVddp9MIYj+guzOdRztzOSANHFSxMglx/2U=
User-Agent: KMail/1.9.3
In-Reply-To: <7v3b876esd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32273>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnuD0-0007y7-1R for gcvg-git@gmane.org; Sat, 25 Nov
 2006 10:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966382AbWKYJw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 04:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966377AbWKYJw0
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 04:52:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:60895 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966382AbWKYJwZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 04:52:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so824846uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 01:52:23 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr8582489ugj.1164448343753; Sat, 25
 Nov 2006 01:52:23 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id e33sm15058840ugd.2006.11.25.01.52.23; Sat, 25 Nov
 2006 01:52:23 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> ---
>> This patch was send to git mailing list; I don't know if it
>> was missed, or rejected.
> 
> I do not remember looking at it deeply, so probably it was just
> lost in the noise.
> 
> Unless there was a list discussion that was unfavorable, that
> is; but I do not recall one and the patch looks sane.

There was no discussion, so probably the patch was just lost in the 
noise. It happens.
-- 
Jakub Narebski
