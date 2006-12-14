X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 22:08:28 +0700
Message-ID: <fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com>
References: <200612132200.41420.andyparkins@gmail.com>
	 <20061213225627.GC32568@spearce.org>
	 <200612140908.36952.andyparkins@gmail.com>
	 <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:08:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bZEEr5QqZ2TYD6BAIFzEA+LTmdouwppF9fr8zW9eRcCgOfCPGisneQQX0t4/N53207dPL+bYti+qrs/0JdtY40cIXyUP1+zAZ88E5LQm7XoojLuFKAutsXrzTsmd9f6y/wDQhgG3f+8d82QMu/S1xrNjQyz7sE10+RH71jD5A/g=
In-Reply-To: <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34345>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GusCN-00023b-1b for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932779AbWLNPIc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLNPIb
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:08:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:35786 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932779AbWLNPIa (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 10:08:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so524325uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 07:08:29 -0800 (PST)
Received: by 10.78.166.7 with SMTP id o7mr736396hue.1166108909037; Thu, 14
 Dec 2006 07:08:29 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 14 Dec 2006 07:08:28 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 12/14/06, Junio C Hamano <junkio@cox.net> wrote:
> If a Porcelain level "ls" is needed (and I am doubtful about
> usefulness of "svn list -r538" like command), that is the
> command you would want to teach about using ls-files and ls-tree
> depending on what the end users want in their workflow.

+1. Any chance git-ls can go to 1.5.0?
-- 
