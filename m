X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Mon, 4 Dec 2006 21:46:06 +0100
Message-ID: <200612042146.06419.jnareb@gmail.com>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com> <el1nsi$vat$1@sea.gmane.org> <20061204202102.GH940MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 20:44:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dw7mTJxfqwMBXxHjX7lG4vbCxG04+HNBXNtdh5hSgzc9LuUJOlvD5jZqJ8WTMqQIirn1Mgf9wusL+FdyBnSwJlbbliyNeO6iutbX0ibH5yYqahI9J46D44xJcLREVhggXmQe6e9TWaTS5KqJx35VYs9m69FR3/K4Qlg5R8n7cMo=
User-Agent: KMail/1.9.3
In-Reply-To: <20061204202102.GH940MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33244>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKfn-0002Eg-NJ for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966656AbWLDUoM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966913AbWLDUoM
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:44:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:56611 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S966656AbWLDUoJ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 15:44:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3118202uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 12:44:07 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr11326544ugl.1165265047245; Mon, 04
 Dec 2006 12:44:07 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id j1sm4921561ugf.2006.12.04.12.44.06; Mon, 04 Dec
 2006 12:44:07 -0800 (PST)
To: Sven Verdoolaege <skimo@kotnet.org>
Sender: git-owner@vger.kernel.org

Sven Verdoolaege wrote:

> On Mon, Dec 04, 2006 at 07:05:04PM +0100, Jakub Narebski wrote:
>>
>> If this [dirdiff] has support for git, could you add it to GitWiki:
>>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> 
> Well, it's not exactly user friendly at the moment.
> Plus, it's not my tool.  I just made a couple of changes to get
> it to work for me.
> 
> I noticed Paul was working on a different tool lately, but I haven't
> had time to check it out.  Maybe it does the same and more.

If it is GPL, you can post it anyway. As I understand from log
you have added git interface, isn't it? You are then perfectly
in the right to post info at GitWiki about this tool.
-- 
Jakub Narebski
