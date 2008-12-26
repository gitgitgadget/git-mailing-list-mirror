From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always use --signoff.
Date: Sat, 27 Dec 2008 07:02:28 +0900
Message-ID: <20081227070228.6117@nanako3.lavabit.com>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Fri Dec 26 23:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGKna-0002wN-F0
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 23:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbYLZWDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 17:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYLZWD3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 17:03:29 -0500
Received: from karen.lavabit.com ([72.249.41.33]:48388 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbYLZWD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 17:03:28 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 09B6AC7A6D;
	Fri, 26 Dec 2008 16:03:28 -0600 (CST)
Received: from 8158.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id QBW6ZQPJJ7Q2; Fri, 26 Dec 2008 16:03:28 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=e6GPz9z6ctvxjGEQkxez0LzpvpIX2BxuTR8k7yJkcQoJUd5b6a53iMSY5E8AzwaNRYWqPqCZAn3wrxcQuHYNWsvI69EJtsAQjTpUbejzwAe3N43JqHMneY2BXESDoFiU/i8RSoWDJPlDp1EUE9OlKxFQG+mgWClE7uWbIB3t0r0=;
  h=From:To:Cc:Subject:Date:MIME-Version:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103955>

Quoting Adeodato Sim=C3=B3 <dato@net.com.org.es>:

> I wrote:
>> Has there even been talk of a commit.signoff configuration variable
>> to always add a S-o-b line? This could allow to enable it on a
>> per-project basis, which would be cool.

There was a discussion in "http://thread.gmane.org/gmane.comp.version-c=
ontrol.git/32503/focus=3D32522" about automatically adding S-o-b line.

Even though Junio said in his response "it certainly is a possibility",=
 another solution that he referred to as "cleaner and more useful" in h=
is message was made available in version 1.5.3 after this discussion.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
