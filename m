From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Sat, 17 Apr 2010 15:58:43 -0700
Message-ID: <86zl118z4s.fsf@red.stonehenge.com>
References: <cover.1271432034.git.grubba@grubba.org>
	<874ojbqnry.fsf@jondo.cante.net> <86ljcnclvu.fsf@red.stonehenge.com>
	<87eiid6fjc.fsf@jondo.cante.net> <86eiidan59.fsf@red.stonehenge.com>
	<n2kfabb9a1e1004171507r3f51d18bq3ff60831370f9b10@mail.gmail.com>
	<m3iq7pemnw.fsf@localhost.localdomain>
	<g2xfabb9a1e1004171547we6a74176v4a697ded96e9f115@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 00:59:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Gyb-0005Gw-Ul
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 00:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab0DQW6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 18:58:44 -0400
Received: from red.stonehenge.com ([208.79.95.2]:52085 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573Ab0DQW6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 18:58:43 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 83327D4D7; Sat, 17 Apr 2010 15:58:43 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.5.1; tzolkin = 13 Imix; haab = 14 Pop
In-Reply-To: <g2xfabb9a1e1004171547we6a74176v4a697ded96e9f115@mail.gmail.com>
	(Sverre Rabbelier's message of "Sun, 18 Apr 2010 00:47:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145190>

>>>>> "Sverre" == Sverre Rabbelier <srabbelier@gmail.com> writes:

>> We use idiomatic Perl, e.g.

Sverre> Ah, I thought that the discussion was about whether the "$_" syntax
Sverre> was idiomatic or not. It got the impression that the "$ARG etc. is a
Sverre> failed experiment" was Randal's personal opinion, but if that's how
Sverre> the perl community has decided that things should be done than that's
Sverre> of course how we should do it :).

Yes.  Within the Perl community, $_ is idiomatic.

"use English" is discouraged.  It was an interesting experiment, but it
failed.

Please stop making me repeat myself.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
