From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] fast importer for SCCS files
Date: Tue, 22 Jan 2008 17:10:48 +1300
Message-ID: <47956CC8.3000307@vilain.net>
References: <c5df85930801200312o7cd5d307v1a39fb35179249a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: James Youngman <jay@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 05:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHATr-0006N0-Ii
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 05:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYAVEKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 23:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbYAVEKy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 23:10:54 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:48433 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbYAVEKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 23:10:54 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 59E6A21D114; Tue, 22 Jan 2008 17:10:52 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 8745621D108;
	Tue, 22 Jan 2008 17:10:48 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <c5df85930801200312o7cd5d307v1a39fb35179249a9@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71414>

James Youngman wrote:
> The attached patch implements an importer for SCCS files using
> git-fastimport.

FWIW, here's another;

http://search.cpan.org/src/HMBRAND/VCS-SCCS-0.11/examples/sccs2git-gfi

Sam.
