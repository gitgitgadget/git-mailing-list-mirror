From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git add <single file> and git add <list of files> behave
 differentely for ignored files
Date: Thu, 4 Dec 2014 14:11:00 +0300
Message-ID: <20141204141100.742f32d74dbf8d65abc8c6ae@domain007.com>
References: <CAMDzUtzQJoEi17OfX8FPOV6SDJ_ytJSH-YTKx2DtUON35-EVSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 12:11:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwUJT-0004an-8Y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 12:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbaLDLLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 06:11:06 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:59493 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbaLDLLF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 06:11:05 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id sB4BB0Np008939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Dec 2014 14:11:01 +0300
In-Reply-To: <CAMDzUtzQJoEi17OfX8FPOV6SDJ_ytJSH-YTKx2DtUON35-EVSg@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260754>

On Thu, 4 Dec 2014 10:06:23 +0100
Guilherme <guibufolo@gmail.com> wrote:

> I reported this issue on the git-user mailing list and they
> redirected me here.
> 
> The problem I have observed is that with a ignored path `git add
> <single file>` behaves differently then `git add <list of files>`.
[...]

To those who's interested the original thread on git-users is
https://groups.google.com/d/topic/git-users/322tole9am8/discussion
