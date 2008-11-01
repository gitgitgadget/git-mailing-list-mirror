From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Sat, 1 Nov 2008 11:03:56 +0100
Message-ID: <adf1fd3d0811010303g18b8077bvb80dc6475a9ada00@mail.gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
	 <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
	 <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
	 <20081028191234.GS24201@genesis.frugalware.org>
	 <20081028213144.GC10862@mit.edu> <87ljw3zx8i.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Florian Weimer" <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 11:05:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwDLz-00059K-Tx
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 11:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYKAKD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 06:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbYKAKD6
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 06:03:58 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:35680 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYKAKD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 06:03:58 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1561442muf.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 03:03:56 -0700 (PDT)
Received: by 10.103.46.12 with SMTP id y12mr5985847muj.130.1225533836140;
        Sat, 01 Nov 2008 03:03:56 -0700 (PDT)
Received: by 10.103.179.20 with HTTP; Sat, 1 Nov 2008 03:03:56 -0700 (PDT)
In-Reply-To: <87ljw3zx8i.fsf@mid.deneb.enyo.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99724>

On Sat, Nov 1, 2008 at 9:06 AM, Florian Weimer <fw@deneb.enyo.de> wrote:
>
> (Admittedly, I'm horribly totally by Git's behavior in this area.  I
> haven't figured out yet under what circumstances tags are pushed and
> pulled, so I'm not totally opposed to the Mercurial model. 8-/)

Tag are pushed when you tell it so, and pulled if they are pointing to
the history you have, or you can ask to fetch them explicitly.

HTH,
Santi
