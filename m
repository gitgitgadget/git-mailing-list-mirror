From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 17:54:29 +0530
Message-ID: <e72faaa81002120424y5d54f6e9y9013d416057d962a@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
	 <20100211214833.GU9553@machine.or.cz>
	 <201002120502.43565.chriscool@tuxfamily.org>
	 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
	 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
	 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
	 <20100212113538.GV9553@machine.or.cz>
	 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
	 <20100212121844.GK4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 12 13:24:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfuZX-0004VW-VS
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab0BLMYb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 07:24:31 -0500
Received: from mail-yw0-f183.google.com ([209.85.211.183]:65177 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab0BLMYa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 07:24:30 -0500
Received: by ywh13 with SMTP id 13so2533423ywh.20
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 04:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pjl5YQSArFII+0GMayBn8vwkzO96piiBfDcPZTppWIY=;
        b=DiX3o9TERrKbnQ5xRXMjAPt0F7N4dRQjlXOAXe4LUZ3pbVDm01ZoALdMSvc6ZL1HHR
         qKn7EEzyoko4zX8ZuEO6EmoqZ0gdQSpOVlbcqR1sI0JDFvDVkIgNQ3ahZK5glL79Rj6G
         GvXU42kk9DH0zrO03bulBDBdQlPEe0sx7yBic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wXy0f2gqE5FZyOD/k1BMCtkYAYgGeyc9+UfUAX8Hig0kzPU6C27EJhKEyj3mpUW+Mc
         ImO3/cbnoJp5w54rxDt0uGxaqaE1rh4BZiIeQI8+grS1BktbgE/6zI4xSNbbDoDxVTgT
         EMHaCHJYjYNhfJx5RrBp/yzRVjxR0YEypF+vI=
Received: by 10.91.49.17 with SMTP id b17mr1380936agk.69.1265977469576; Fri, 
	12 Feb 2010 04:24:29 -0800 (PST)
In-Reply-To: <20100212121844.GK4159@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139694>

> =A0However, I'm a bit unsure if you aren't loading too much on yourse=
lf,
> seeing how much effort it took the other projects to implement *just =
the
> read-only parts* properly. So I still wonder why it wouldn't be bette=
r
> to focus purely on the editing and commit creation, while relying on
> an existing web interface to provide the history browsing, diffs, etc=
=2E

Yeah, My GSoC project will consist of this. Remaining all
functionalities will be coded after i finish GSoC.

> =A0This could be done in several ways - simply taking a client and ad=
ding
> your code to provide the extra functionality there, OR creating a
> standalone project that would be cross-linked with a given web
> interface. The latter option is interesting since your extension coul=
d
> work easily with the web interfaces of choice (and e.g. modifying git=
web
> to provide the appropriate links is trivial, to a degree even possibl=
e
> purely from config file).

I am intended to link it with gitweb.

> =A0P.S.: I could volunteer to mentor such a project, if no more activ=
e
> Git hacker shows interest. Perhaps Jakub Narebski might be interested=
?

Wow. That's great, If u could get a confirmation that somebody is
willing to mentor this, then i can start the project even before the
start of GSoC itself.

-pavan
