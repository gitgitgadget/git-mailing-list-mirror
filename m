From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 18:25:04 -0500
Message-ID: <nngipgo1zn3.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de>
	<nngbomh3uz0.fsf@transit.us.cray.com>
	<201204241759.q3OHxSbH017287@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, <greened@obbligato.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 01:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMp6s-0001uq-FR
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 01:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab2DXXZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 19:25:22 -0400
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:46730 "EHLO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab2DXXZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 19:25:21 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob105.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5c2Vsp5g+eziRl1+LXO5f2y8mU8c/00@postini.com; Tue, 24 Apr 2012 16:25:21 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 24 Apr
 2012 18:25:09 -0500
In-Reply-To: <201204241759.q3OHxSbH017287@no.baka.org> (Seth Robertson's
	message of "Tue, 24 Apr 2012 13:59:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196289>

Seth Robertson <in-gitvger@baka.org> writes:

> I have a document I created for gitslave which I have cleaned up a bit
> and might be the start of such comparison.

I'll look through this is more detail and I think some of the text
can be combined with other contributions.  I just asked Jens if he wants
to create a topic branch on which we may collaborate.

My inclination is to limit the documentation to what's in the upstream
repository, which would eliminate repo, mr and unfortunately, for the
time being, git slave, but that's just one opinion and it's a newbie
opinion at that.  :) Please don't take it as knocking git-slave because
I think it's really cool.  I would like to see it go upstream!

                             -Dave
