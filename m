From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 16:16:05 +0200
Message-ID: <20060418141605.GD4720@wohnheim.fh-wedel.de>
References: <20060418141050.7941.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 16:16:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVr0C-00045n-5k
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 16:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWDROQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWDROQV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 10:16:21 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:48336 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932152AbWDROQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 10:16:20 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVqzt-0005bi-00; Tue, 18 Apr 2006 16:16:05 +0200
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060418141050.7941.qmail@science.horizon.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18855>

On Tue, 18 April 2006 10:10:50 -0400, linux@horizon.com wrote:
>=20
> Just to cover the obvious "is it plugged in?" questions, did you
> also "export GIT_OBJECT_DIRECTORY"?  That is, what does
> 	env | grep GIT_OBJECT_DIRECTORY
> produce?

$ env | grep GIT_OBJECT_DIRECTORY
GIT_OBJECT_DIRECTORY=3D/home/joern/.git

And maybe for the record, I just the debian unstable package:
$ git --version
git version 1.2.1


J=F6rn

--=20
Anything that can go wrong, will.
-- Finagle's Law
