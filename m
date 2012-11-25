From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 12:36:07 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125173607.GB32394@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 18:37:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcg8s-00089Q-P3
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 18:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab2KYRhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 12:37:00 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43222
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2KYRg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 12:36:59 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id CC1D24065F; Sun, 25 Nov 2012 12:36:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210377>

Felipe Contreras <felipe.contreras@gmail.com>:
> Of course, but there are experts in C and shell around, not so many
> python experts. So if somebody sneaks in a python program that makes
> use of features specific to python 2.7, I doubt anybody would notice.

I would.

> And if they did, I doubt that would be reason enough for rejection,
> supposing that porting to 2.6 would be difficult enough.

In cases like that, backporting is usually pretty easy.  Been there, done that.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
