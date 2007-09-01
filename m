From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 18:23:33 -0700 (PDT)
Message-ID: <156525.53603.qm@web31809.mail.mud.yahoo.com>
References: <20070901011608.GC10749@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 01 03:24:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRHiU-0001wN-Se
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 03:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbXIABXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 21:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXIABXg
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 21:23:36 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:31500 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751206AbXIABXg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 21:23:36 -0400
Received: (qmail 53618 invoked by uid 60001); 1 Sep 2007 01:23:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=in2VJ4E4MPVrIfwHXNQ0+dGrd4n9G439VL/xkVHTTJDJIz4pGSCKOpbvmP9vLKJBOdEXUe2HFMUHPpv2BKdnbBY/zgOsDR5BpZBwcdrF6Cmtx5+5SJOduqN6a2lolTlaDSzYHEzqhyCDwYNHEriSezUyID+Qj/ErDaAtmqRSD5s=;
X-YMail-OSG: obPEASwVM1k8IobDRQQU7z6FWqvfRzuZWnp1kxslDPJ7_D98cgpYE74n0xoxtNkcoiWWcjWU0XKau8d0a01omklzsk2TB_hCdF_XyyU8QuijWyI-
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Fri, 31 Aug 2007 18:23:33 PDT
In-Reply-To: <20070901011608.GC10749@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57239>

--- Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Sep 01, 2007 at 03:06:02AM CEST, Luben Tuikov wrote:
> > --- Petr Baudis <pasky@suse.cz> wrote:
> > >   Hi,
> > > 
> > >   due to popular (Junio's) demand, I have set up a gitweb-oriented fork
> > > of git at repo.or.cz:
> > > 
> > > 	http://repo.or.cz/w/git/gitweb.git
> > > 
> > >   It is meant as a hub for various gitweb-related patches and
> > > development efforts. So far it is pre-seeded by the patches repo.or.cz's
> > > gitweb uses.
> > 
> > Is this right?
> > 
> > So what's the review process now?  "Because it is part of repo.or.cz's
> > gitweb" seems to be a weak argument.
> 
> Have you even looked at the page I linked? I tried to explain how are
> the patches organized to branches there. Please ask if something is
> still unclear.

Yes, I did.  I saw that gitweb::master is identical to Junio's, but
for safety measure I decided to ask.  Thanks for your reply.

   Luben
