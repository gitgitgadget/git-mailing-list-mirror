From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: New release?
Date: Tue, 6 Jun 2006 14:42:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606061439500.28953@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606061019440.11478@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virnevath.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 14:43:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnatt-0001me-VU
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 14:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWFFMnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFFMnD
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 08:43:03 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62161 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751313AbWFFMnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 08:43:01 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C302B1CF6;
	Tue,  6 Jun 2006 14:42:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B74AC1CDB;
	Tue,  6 Jun 2006 14:42:59 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 99ECD1C5E;
	Tue,  6 Jun 2006 14:42:59 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virnevath.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21376>

Hi,

On Tue, 6 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 5 Jun 2006, Junio C Hamano wrote:
> >
> >>          - letting fetch-pack ask for an arbitrary commit object the
> >>            user obtained out of band (Eric W Biederman) -- waiting for
> >>            updated patch.  We would need a corresponding one-liner patch
> >>            to upload-pack when we do this.
> >> 
> >> This can wait.
> >
> > I think that this could be an important step towards a sensible "shallow 
> > clone"...
> 
> I did not say we are not interested in doing this ever.

I was not trying to make a case to wait with 1.4.0...

> Also, what you talk about the "lazy clone" is a lot more involved than 
> what Eric wanted to have.

A little more involved. And I wanted to know what people think about this 
way to tackle shallow clones.

Ciao,
Dscho
