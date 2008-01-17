From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Thu, 17 Jan 2008 08:45:59 +0100
Message-ID: <20080117074559.GB25213@diana.vm.bytemark.co.uk>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <200801162147.33448.kumbayo84@arcor.de> <200801162158.26450.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Pavel Roskin <proski@gnu.org>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 08:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFPUA-00025V-Cx
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 08:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbYAQHqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 02:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbYAQHqd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 02:46:33 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1883 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901AbYAQHqb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 02:46:31 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JFPRn-0006dB-00; Thu, 17 Jan 2008 07:45:59 +0000
Content-Disposition: inline
In-Reply-To: <200801162158.26450.kumbayo84@arcor.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70837>

On 2008-01-16 21:58:26 +0100, Peter Oberndorfer wrote:

> "git repo-config" will be removed soon
>
> Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>

Thanks, I'll apply this tonight. (Along with Pavel's "stg edit --sign"
patch, which I've been neglecting for quite a while now. Sorry!)

> since i am not good at creating log messages, feel free to change it =
:-)

I'm going to end the commit message body sentence with a period, but
otherwise it's totally OK.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
