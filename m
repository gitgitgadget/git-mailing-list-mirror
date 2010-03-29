From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Tue, 30 Mar 2010 01:34:53 +0530
Message-ID: <f3271551003291304u27c56d8fr648d7546f6256857@mail.gmail.com>
References: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com> 
	<20100327091938.GA4395@thyrsus.com> <f3271551003280225v17af30d4s6d3d24b4d548ff7d@mail.gmail.com> 
	<20100328121034.GC25402@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Peter Baumann <waste.manager@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Dave Olszewski <cxreg@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Steven Michalske <smichalske@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Mar 29 22:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwLD8-0002jA-Rd
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 22:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab0C2UFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 16:05:16 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:36853 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab0C2UFO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 16:05:14 -0400
Received: by gxk9 with SMTP id 9so1843406gxk.8
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dkqJo5ytWGkKls9NL/hNpvQFJTluGhBpu8Jiz2jAHNw=;
        b=tHnYAtjNOZXQSGXEJHsQrwvoeRUG4OsPgkGjoqYqm2i7eLpf4QWrCjh41mNyVFbUTJ
         e2/wG7NaQpEYF5mnx2baKDlCVXVdjLE8YURb/lvOl3tR0liSq35Is1xhDwl5ntIG4ybD
         nbFdZPQQOFrBjgHChVWf38bumudp75k2HKt48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FkI5JJ9wiiliwyp7Cy8MJI33kuoB6STlhtplESBAEMmj/yBjVUc2OWsWFMYzzrTXzx
         lR85Ay1M8l+dwNPwH5OEMiwy7S2I28qSjFu2s7sz0m8E4qgKZfh6yzBX4aJ4LOjtuBa0
         34GU11J1N0/LullEZ/HZt+xOcB6Y9ug4VEmf4=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 13:04:53 -0700 (PDT)
In-Reply-To: <20100328121034.GC25402@thyrsus.com>
Received: by 10.90.60.3 with SMTP id i3mr4396489aga.103.1269893113237; Mon, 29 
	Mar 2010 13:05:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143512>

Hi,

Just a quick heads up: I've submitted my proposal via Google.

On Sun, Mar 28, 2010 at 5:40 PM, Eric Raymond <esr@thyrsus.com> wrote:
> Accordingly, I support Ramkumar's proposal to rethink and rewrite the
> Subversion interface. =A0A concerted effort to do seamless interopera=
bility
> would be well justified given the ubiquity of Subversion. =A0I think =
Rankumar
> has chosen a goal that is useful, well defined, and realistically sco=
ped.

Thank you :) I'll do my best.

-- Ram
