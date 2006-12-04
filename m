X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Mon, 4 Dec 2006 23:35:03 +0100
Message-ID: <200612042335.03802.jnareb@gmail.com>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com> <200612042146.06419.jnareb@gmail.com> <20061204215134.GJ940MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 22:33:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jx/PIsuhkYiUtKKxPbgC5H+UoHXUj0+TpSV8TvwR9CzsO4tFUd5AiTyCyM1629QT/zF2ReYRn7PsC6/ppLXoriAOvs+xC3iPOfVAynf/KV71KHsmFQ4cCGHI2SchMgMdSfoY6hnuDFzLwj12AHpEpl7OhrqW2J0xK9WfZt5HmUs=
User-Agent: KMail/1.9.3
In-Reply-To: <20061204215134.GJ940MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33263>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrMN0-0002ge-SR for gcvg-git@gmane.org; Mon, 04 Dec
 2006 23:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937435AbWLDWdB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 17:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937436AbWLDWdB
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 17:33:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:22124 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937435AbWLDWdA (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 17:33:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3146166uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 14:32:59 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr12743898ugl.1165271578894; Mon, 04
 Dec 2006 14:32:58 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id u1sm2776768uge.2006.12.04.14.32.58; Mon, 04 Dec
 2006 14:32:58 -0800 (PST)
To: Sven Verdoolaege <skimo@liacs.nl>
Sender: git-owner@vger.kernel.org

Sven Verdoolaege wrote:
> On Mon, Dec 04, 2006 at 09:46:06PM +0100, Jakub Narebski wrote:
>>
>> If it is GPL, you can post it anyway. As I understand from log
>> you have added git interface, isn't it?
> 
> I think Paul added the ability to compare a git tree to a (set of)
> directory trees, while I add a primitive way of committing partial
> changes to a git branch.  It's been over a year, though, so I may
> be mistaken.

Logs are there... ;-)
 
>> You are then perfectly
>> in the right to post info at GitWiki about this tool.
> 
> I feel like I should check first that it hasn't been obsoleted by
> some other tool already and I currently don't have the time to
> investigate.

It doesn't look like this.
-- 
Jakub Narebski
