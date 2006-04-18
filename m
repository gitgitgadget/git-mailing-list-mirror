From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Tue, 18 Apr 2006 13:07:09 +0200
Message-ID: <20060418110709.GA25558@diana.vm.bytemark.co.uk>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk> <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com> <tnxbqx6z592.fsf@arm.com> <20060412191655.GD27397@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 13:07:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVo3I-00035K-FE
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 13:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWDRLHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 07:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWDRLHV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 07:07:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:51217 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932152AbWDRLHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 07:07:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FVo33-0006s4-00; Tue, 18 Apr 2006 12:07:09 +0100
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060412191655.GD27397@nowhere.earth>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18851>

On 2006-04-12 21:16:55 +0200, Yann Dirson wrote:

> Is this still being worked on?

I haven't worked any more on the slashes-in-branch-names patch, but I
have been using it myself, and it works for me. Getting that fancy new
test suite to excercise it would be a really good next step . . .

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
