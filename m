From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Default history simplification
Date: Fri, 20 Nov 2009 09:55:37 +0100
Message-ID: <20091120095537.1909f6b6@perceptron>
References: <ae09c2a40911191530y626dd035q90de0212e0b4b6d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Tommy Wang <subscription@august8.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 09:56:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBPIH-0002TF-Jy
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 09:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbZKTI4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 03:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbZKTI4H
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 03:56:07 -0500
Received: from zoidberg.org ([88.198.6.61]:33087 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbZKTI4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 03:56:05 -0500
Received: from perceptron (pC19EBA05.dip.t-dialin.net [::ffff:193.158.186.5])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 20 Nov 2009 09:56:08 +0100
  id 004D0117.4B0659A9.00006A90
In-Reply-To: <ae09c2a40911191530y626dd035q90de0212e0b4b6d8@mail.gmail.com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133316>

Hi,

Tommy Wang <subscription@august8.net> wrote:
> [...] I would love to simply use the rev-list built-in to
> do my work for me; but I fear that I may have much too many path
> limiters than the linux command-line can handle (which if I'm correct,
> can only take so many arguments).

On my system, "only so many arguments" means about two megabytes worth
of command line. On several operating systems, "getconf ARG_MAX" can
tell you the approximate limit (which I think includes the space for
environment variables).

I don't really have any comments about the other things you said.

Jan
