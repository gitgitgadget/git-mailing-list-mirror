From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: organizing multiple repositories with dependencies
Date: Wed, 25 Apr 2012 08:48:23 -0400
Message-ID: <201204251248.q3PCmN2F007496@no.baka.org>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com> <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com> <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com> <nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de> <nngbomh3uz0.fsf@transit.us.cray.com> <201204241759.q3OHxSbH017287@no.baka.org>
        <nngipgo1zn3.fsf@transit.us.cray.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, greened@obbligato.org
To: dag@cray.com
X-From: git-owner@vger.kernel.org Wed Apr 25 14:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN1eO-0004Au-3h
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 14:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825Ab2DYMst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 08:48:49 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:44178 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322Ab2DYMss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 08:48:48 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q3PCmO1B009373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 25 Apr 2012 08:48:24 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q3PCmN2F007496;
	Wed, 25 Apr 2012 08:48:23 -0400
In-reply-to: <nngipgo1zn3.fsf@transit.us.cray.com>
Comments: In reply to a message from "<dag@cray.com>" dated "Tue, 24 Apr 2012 18:25:04 -0500."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196314>


In message <nngipgo1zn3.fsf@transit.us.cray.com>, dag@cray.com writes:

    My inclination is to limit the documentation to what's in the upstream
    repository, which would eliminate repo, mr and unfortunately, for the
    time being, git slave, but that's just one opinion and it's a newbie
    opinion at that.  :) Please don't take it as knocking git-slave because
    I think it's really cool.  I would like to see it go upstream!

So would I, and I'm also happy to do work to cause that to happen, but
the question is would it be accepted?

					-Seth Robertson
