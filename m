From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: [PATCH] Initial Italian translation of git-gui.pot
Date: Mon, 23 Jul 2007 11:00:45 +0200
Message-ID: <34a7ae040707230200n6d3f839ua10bf38740d4fe3c@mail.gmail.com>
References: <20070722124236.47baacb1@paolo-desktop>
	 <200707222128.05884.barra_cuda@katamail.com>
	 <Pine.LNX.4.64.0707222121500.14781@racer.site>
	 <4d8e3fd30707221510t8bfc3ecr2dbec5a817519212@mail.gmail.com>
	 <Pine.LNX.4.64.0707222315360.14781@racer.site>
	 <e5bfff550707221525w3234c5edte3c3d58b97d4d970@mail.gmail.com>
	 <4d8e3fd30707221530v46989d88mcc65cacbc66a4e1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	Michael <barra_cuda@katamail.com>, git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 11:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICtme-0001tM-Du
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 11:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbXGWJAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 05:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbXGWJAs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 05:00:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:20459 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbXGWJAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 05:00:47 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1131293ugf
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 02:00:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j6SNY0woFcIJmBPt5+OmdMCU69jHP5Uppjxzv/5TxjpcphzAF+yB5K/Ki0VaVO2pFQeuekbdqtyuaPDPWQML9BwLgq1mWUXHjVeI07N1P2WHrVQYzKIyYAiCiFamBhtGfHUNuDyrEThaZzruuea1nTe58S8Jgice+tZvIq+fwlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SCRx2xOP7iybAe78kLKlEUqq1cdHs2QS5ouv4wjoJVQxO79N1DQAZ2SwqzGNBNhx6/HlFguzQm23RDfOeoUe7G8T3KmcVy/6q78gGP9DCzaX281WncEZz1VIkm81Z6lcainNwAeX/3zyaCyFC34adWPvdmTY9AyEC4UddGvUF7A=
Received: by 10.78.107.8 with SMTP id f8mr708859huc.1185181245410;
        Mon, 23 Jul 2007 02:00:45 -0700 (PDT)
Received: by 10.78.183.11 with HTTP; Mon, 23 Jul 2007 02:00:45 -0700 (PDT)
In-Reply-To: <4d8e3fd30707221530v46989d88mcc65cacbc66a4e1c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53415>

2007/7/23, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>:
> On 7/23/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > On 7/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Forse "parte" e troppo generale per dire "hunk"?
> > >
> >
> > There are some words that in my opinion it would be better do not
> > translate but to leave in english, expecially on computer stuff
> > italian people it's already used to the original english word.
>
> Agree. We just have to agree on which words keep in English.

I'm not in love with translation of 'programming tools', but is better
to keep in English
at least words like: 'Commit', 'Reset', 'Merge', 'Commit Message' and 'Hunk'

Also is better to avoid adding context or extra words during translation .

For example in translation like "Rescan" to "Riesamina il database" the word
"database" is superfluous.

"Rescan"-> "Riesamina".. is ok

Is like the typical menu item File -> Save.. The word 'Save' has a
precise context and is
superfluous to traslate it as "Salva File" (that sound like "File ->
Save File").

Paolo
