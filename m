From: "Philip Oakley" <philipoakley@iee.org>
Subject: Manually decoding a git object
Date: Sun, 19 Feb 2012 18:07:51 -0000
Organization: OPDS
Message-ID: <A716A27D407F401DAAC373027D5CFF2A@PhilipOakley>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com> <1329624946-32173-1-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 19 19:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzBlF-00023e-TJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 19:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab2BSSpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 13:45:21 -0500
Received: from smtp2go.com ([207.58.142.213]:60423 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab2BSSpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 13:45:20 -0500
X-Greylist: delayed 2253 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Feb 2012 13:45:20 EST
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191027>

If I have a renamed file which is a git object, such a "Git_Object", was
8c-something-or-other, what is the easiest way of examining / decoding /
recreating the original file (either as its sha1, or a cat-file).

I don't appear to be able to unzip the file in its raw format...  I'm using
Msysgit on windows XP.

Philip
