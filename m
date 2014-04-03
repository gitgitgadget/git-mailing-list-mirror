From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Thu, 3 Apr 2014 17:48:08 +0400
Message-ID: <20140403174808.9ae91c3bd477d276e3e80d68@domain007.com>
References: <20140403131850.GA24449@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: marat@slonopotamus.org
X-From: git-owner@vger.kernel.org Thu Apr 03 15:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVi0b-0004RC-QL
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 15:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbaDCNsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 09:48:41 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:58385 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbaDCNsk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 09:48:40 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id s33Dm87o000905;
	Thu, 3 Apr 2014 17:48:09 +0400
In-Reply-To: <20140403131850.GA24449@seldon>
X-Mailer: Sylpheed 3.3.1 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245737>

On Thu, 3 Apr 2014 17:18:50 +0400
marat@slonopotamus.org wrote:

> I'm proud to announce WinGit:
> an attempt to bring Git powers to 64-bit Windows.
[...]
> Relationship with msysgit
> =========================
> 
> Unlike msysgit, WinGit is a pure-Windows binary build with MSVC.
> 
> Like msysgit, WinGit also uses msys environment (sh/perl/etc) both
> during build-time and runtime.
> 
> WinGit adds a few patches to Git itself on top of msysgit ones.
> Patches are required due to insufficient testing of MSVC builds
> (caused by total absence of any MSVC-built Git distributions).
> 
> All WinGit patches are sent upstream, just didn't get to master yet.

What is the state of Unicode support in WinGit?
