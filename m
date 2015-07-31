From: alan@clueserver.org
Subject: Re: Rebase bug
Date: Fri, 31 Jul 2015 14:44:46 -0700
Message-ID: <7b32dd1872a8a110caffd5a58d535870.squirrel@clueserver.org>
References: <14fe2a0c9b92fc27d3ab5b2083cb16b2.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: alan@clueserver.org
X-From: git-owner@vger.kernel.org Fri Jul 31 23:44:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLI6n-00050Y-32
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 23:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbbGaVot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 17:44:49 -0400
Received: from clueserver.org ([65.102.45.174]:46295 "EHLO clueserver.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbbGaVor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 17:44:47 -0400
Received: from clueserver.org (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id C46B86008D7;
	Fri, 31 Jul 2015 14:44:46 -0700 (PDT)
Received: from 192.55.55.41
        (SquirrelMail authenticated user alan)
        by clueserver.org with HTTP;
        Fri, 31 Jul 2015 14:44:46 -0700
In-Reply-To: <14fe2a0c9b92fc27d3ab5b2083cb16b2.squirrel@clueserver.org>
User-Agent: SquirrelMail/1.4.22-14.fc20
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275081>

> I think I have identified an obscure bug. I have a reproducible test case.
> I am trying to come up with enough of a test case that can be used for
> finding and fixing the issue.

BTW, I have tested this on 1.7.6.6 and 2.5.0. Same results on either version.
