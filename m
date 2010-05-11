From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Tue, 11 May 2010 13:44:09 +0400
Organization: '
Message-ID: <20100511094409.GB5220@screwed.box>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com> <201005102310.47879.jnareb@gmail.com> <AANLkTimypauJKP-ifPKDmM9TK0u0JsSG5PlcpWdkkbVd@mail.gmail.com> <201005111129.10931.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Tatsuhiko Miyagawa <miyagawa@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 11:44:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBm0t-00005c-U1
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 11:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173Ab0EKJo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 05:44:26 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:49689 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753908Ab0EKJoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 05:44:25 -0400
Received: from localhost (kim.kairosnet.com [69.39.49.199])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 607065A82;
	Tue, 11 May 2010 13:32:49 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005111129.10931.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146882>

I know St. Peter won't call your name, Jakub!
2010/05/11 11:29:07 +0200 Jakub Narebski <jnareb@gmail.com> => To Tatsuhiko Miyagawa :

JN> gitweb running as FastCGI script (using ab, ApacheBench).  Do you know
JN> any pure-Perl FastCGI server with minimal dependencies, and pure-Perl

I'd like to know about the pure-perl FastCGI protocol implementation either, at
least to make tests for FCGI::Spawn.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
