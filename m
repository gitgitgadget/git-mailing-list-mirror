From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: release-notes could be clearer on git-fetch changes
Date: Thu, 20 Feb 2014 10:51:23 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1402200821010.6991@nerf08.vanv.qr>
References: <alpine.LSU.2.11.1402191952070.31131@nerf08.vanv.qr> <xmqqtxbu98ie.fsf@gitster.dls.corp.google.com> <alpine.LSU.2.11.1402192356480.1491@nerf08.vanv.qr> <CAPc5daUgs8cKNnXcdjLy+S7jGN8BnjNzF66HMSz8infmo9Ws3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 10:51:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGQI9-0001en-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 10:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbaBTJvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 04:51:35 -0500
Received: from ares08.inai.de ([46.4.84.70]:40391 "EHLO ares08.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbaBTJva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 04:51:30 -0500
Received: by ares08.inai.de (Postfix, from userid 25121)
	id B7B0E10677D33; Thu, 20 Feb 2014 10:51:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ares08.inai.de (Postfix) with ESMTP id B3C30189D469C;
	Thu, 20 Feb 2014 10:51:23 +0100 (CET)
In-Reply-To: <CAPc5daUgs8cKNnXcdjLy+S7jGN8BnjNzF66HMSz8infmo9Ws3Q@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242428>

On Thursday 2014-02-20 00:40, Junio C Hamano wrote:

>On Wed, Feb 19, 2014 at 2:58 PM, Jan Engelhardt <jengelh@inai.de> wrote:
>      Looking at it from one more angle, `git fetch r --tags` and
>`git push r --tags` is now no longer symmetric :(
>
>
>I would have loved to hear such comments _during_ the discussion, not after
>a release is made,

Perhaps, though I only became aware of this change because LWN reported 
about git 1.9.0.
