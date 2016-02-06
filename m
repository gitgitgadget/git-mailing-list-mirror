From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: changing colors in the tree view in gitk
Date: Sat, 6 Feb 2016 14:55:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602061450300.2964@virtualbox>
References: <CAC4O8c-8cXCfu7GdCS6bx5RMfw_Y8PgPeOhH6Zb5awyi-Qt4tw@mail.gmail.com> <3FAE862069E24321A6E31D9F0CB66E35@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Britton Kerin <britton.kerin@gmail.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 14:56:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS3LJ-0007rE-Mi
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 14:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbcBFN4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 08:56:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:62232 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbcBFNz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 08:55:59 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MZTw5-1akP0C0PSX-00LGAG; Sat, 06 Feb 2016 14:55:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <3FAE862069E24321A6E31D9F0CB66E35@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:46ogtsQ28ozmyxPE+90j7EPMTSb71kjiHugt09UtV6JxbD2F5i6
 mMkocz4lcsDAp/hK3VqUsGXRhgq+m98yNrM1yx0YSG4qV+d8hXhQKSoWK4wZJ0K2zXpTEbc
 BCvz7swPgTsIG7ckkkUVYNvWhK7HD4QSZQ/N+qMnOSl3RT8qLsMgvPIFtfUly32hPb2hoBr
 fcB4sCkChy3lrFIh0/x6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2qbMOsxJs3U=:sWiVNWGD4fb1NN3+4aLTUB
 VV2fbEO1Np2TiK6uN1LEJVAisFGuB21dJDCWF1weqTqZXiiANcigUPVfztVMKfSjbKNzO2rXM
 mBjWxmFqKFmh/63F/P7VCTtHopfjbxSkv0ypwUOXqk2ltRLKdT2LiPsvNHm9ii5zvjL0iqgCC
 CM5o5uMsQZFG8D/FHYtl7y7n5rEc+L8idoxjjRgrlkCsjjJA62Vpt37sTfM1Id3PLfU7hsLGU
 Y9tp8p6VqBZ7+ujdiUFZNyI8l1G6tSZI/4vMkorU5hfzqCIDNeOOA5g2kExb2MIzrWSsBwD+W
 xxXqaLykcFRwBuokI5IpSbXI8FwclR2RMovV7wNHXfH+wj5RDA/VqcNzCtq2ip1LIlNTbjI5E
 3U6L/xrCrjxpLw5jtLEWWyaoXHx2XlKsFApCkBq0jpSiZyeN3dSIr9uwvFBfKvd6DWZpfRZlU
 +rXAG9wDV3849KKmmJUVlwmb4rD0NnkiVtUW58cOuR/Xaye9/UqFvPdjvKSuQX2d5iH1RfULE
 EWuk5Q722mFvNoD9rCwoRRxVm2jztQSB7jDLCq2JEi+62OkJ8vlxI5SWypd1Ctdn0/p5wUtmP
 YiOSP/5WXq47IbXi+IP3CBv5p4XtrguwIszfHcXvvpQ2zJIW0iylP9P1fzdLIV5uUGu2+k8I3
 bmSwz8T36KxwgQXiryb+VaYRnKbwCmjhX3woDI9qpGNKERpLoHXOs5Mykb+ik8ZTUsqBrJAUx
 XsPAurTRVplOF1i5lCiTG44pj4YM9jGpUMmaMI27wrYCTt38+D12i0ogA+U2j8ebACuPUADb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285688>

Hi Philip,

On Fri, 5 Feb 2016, Philip Oakley wrote:

> From: "Britton Kerin" <britton.kerin@gmail.com>
> >I upgraded from 2.5 to 2.7 and the branch names went from a light
> > green to dark green, the names of the tags are hard to read now.
> >
> > Is it possible to configure the branch name color in the tree view?
> > --
> Which Operating System is this on? and which Git version.?
> 
> 
> For the Git for Windows, the Mintty window colours can be adjusted. e.g.
> https://code.google.com/archive/p/mintty/wikis/Tips.wiki
> 
> Though I just changed my config setting for the awkward to read items (for me
> it was color.branch.upstream=green !)

I think Britton was talking about gitk, not about the console.

As it happens, this issue was already reported to the Git for Windows bug
tracker:

	https://github.com/git-for-windows/git/issues/300

It would appear that the culprit is a change in Tcl/Tk, not in gitk. I
outlined a possible solution in that ticket but have no plans to implement
that solution myself.

Ciao,
Johannes
