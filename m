From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Wed, 17 Oct 2007 10:20:03 +0200
Message-ID: <20071017082003.GA10799@diana.vm.bytemark.co.uk>
References: <1192586150-13743-1-git-send-email-nico@cam.org> <1192586150-13743-2-git-send-email-nico@cam.org> <20071017021137.GO13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 10:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii49M-0008Ju-4s
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 10:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbXJQIU4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbXJQIUz
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 04:20:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2837 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbXJQIUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 04:20:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ii48J-0002rj-00; Wed, 17 Oct 2007 09:20:03 +0100
Content-Disposition: inline
In-Reply-To: <20071017021137.GO13801@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61353>

On 2007-10-16 22:11:37 -0400, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
>
> > Each progress can be on a single line instead of two.
>
> Nice. Of course that screws with git-gui and now I have to match two
> regexs and not one. But whatever.

Maybe an env variable could cause the code to emit machine-friendly
progress information instead?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
