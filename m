From: "Ferry Huberts" <ferry.huberts@pelagic.nl>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 13:02:56 +0200 (CEST)
Message-ID: <33520.77.61.241.211.1244458976.squirrel@hupie.xs4all.nl>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
    <26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl>
    <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDcd8-0005wK-Nf
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 13:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbZFHLC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 07:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZFHLC4
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 07:02:56 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:56056 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754431AbZFHLC4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 07:02:56 -0400
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 8AB2F58BDD4; Mon,  8 Jun 2009 13:02:56 +0200 (CEST)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 8 Jun 2009 13:02:56 +0200 (CEST)
In-Reply-To: <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121061>

On Mon, June 8, 2009 12:51, Sverre Rabbelier wrote:
> Heya,
>
> On Mon, Jun 8, 2009 at 12:43, Ferry Huberts<ferry.huberts@pelagic.nl> wrote:
>> this does not work for me.
>
> Perhaps you want to define 'does not work'
>

sure:

This is what cmd.exe says:
HOMEDRIVE=C:
HOMEPATH=\Documents and Settings\hubertsf

This is what Git bash says:
HOMEDRIVE=C:
HOMEPATH='\'

Appearently $HOMEPATH is somehow different.
Note that I do have Cygwin installed, but as far as i can see Cygwin does not cause $HOMEPATH to be set to /
