From: "Philip Oakley" <philipoakley@iee.org>
Subject: [RFC PATCH] Documentation: diff produces patches, which can be 'apply'd
Date: Wed, 9 May 2012 14:17:38 +0100
Organization: OPDS
Message-ID: <18BB8318853C47BDB078EBC2CDE79D98@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 15:17:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS6lg-0000p5-GV
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 15:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759364Ab2EINRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 09:17:19 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:23160 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759335Ab2EINRS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 09:17:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At4TAG9tqk9cHlGK/2dsb2JhbABEgngBNogOpnIBAQKBIYEIgSdLAQETARMBAS4eAQEsAggCASQ5AQQaBgcdGwIBAgMBhTgHAYInGgeaEIZLmn6LJScwaINXYwSIMIVKiRSPMIJqgVUHAQ0
X-IronPort-AV: E=Sophos;i="4.75,558,1330905600"; 
   d="scan'208";a="34307598"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip07ir2.opaltelecom.net with SMTP; 09 May 2012 14:17:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197472>

This attached patch (my first) suggests a couple of small documenation changes for 'diff' based on Junio's supportive comments at
http://article.gmane.org/gmane.comp.version-control.git/197282

The purpose of the patch is to make users aware of the apply command as a companion to diff.

If changing the NAME text is considered inappropriate, the same change could just as easily be applied to the start of the 
DESCRIPTION.

I haven't sorted out using 'send-mail' for patches yet, so I've attached it.
The patch was generated with "git format-patch -M" as per directions.
The patch was on top of tag v1.7.10.msysgit.0 from https://github.com/msysgit/git

Comments?

Philip
