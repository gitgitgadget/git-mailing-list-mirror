From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Wed, 09 Apr 2014 12:27:44 -0500
Message-ID: <534583107c84_af197d308d9@nysa.notmuch>
References: <20140403131850.GA24449@seldon>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: marat@slonopotamus.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 19:40:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXwUb-0000bl-VT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 19:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934034AbaDIRkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 13:40:47 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:55836 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114AbaDIRkn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 13:40:43 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so3080304oag.7
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=GFYPzKE00lxEAbKZDfEYwXjtPOafS4SCTXEPGHITdSU=;
        b=op1b7evGLYBtXDPMNAsCZCxjxkq+XsQpUUNbbZQr8PAOKgFQDvdPR5K/wN225j0yd0
         uEB6epCLY6mnV0Cw4RsGMaelIK790GA2ufg66snieQHbrFtOgEEd/BJDt4hr/eyGurVo
         BEwNWGIKU/nn2V772SV2/MSpnbtYzOawzSXbN3IwpX+7WwpsczCgIqOM9bjh9E91f5XO
         ovl+uguOnsIJzreRSbfIjgYulixHNBELCxCZA//KnA4GcK+Nu2AIHdBsg7n9G7nl288U
         epZIsDV6YiU1BdKfdUT1vZXM/Lf9UhvXxX+gyfppTGorTLTjOMoaZ5XoaCvDVnUS0yde
         lkHQ==
X-Received: by 10.182.233.228 with SMTP id tz4mr3109611obc.56.1397065242585;
        Wed, 09 Apr 2014 10:40:42 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cq1sm6537832oeb.4.2014.04.09.10.40.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 10:40:38 -0700 (PDT)
In-Reply-To: <20140403131850.GA24449@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245982>

marat@ wrote:
> I'm proud to announce WinGit: an attempt to bring Git powers to 64-bit
> Windows.
> 
> WinGit is currently used only by my coworkers and isn't considered
> production-ready-rock-solid. Use at your own risk.

Thank you for doing this, it's very much needed. It would be great if there was
a place to list all the tools that need to be converted to C, so that neither
Perl, nor a shell are needed for most of Git's operations, don't you think?

Cheers.

-- 
Felipe Contreras
