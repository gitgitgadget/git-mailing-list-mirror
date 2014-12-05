From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 21:39:50 +0000
Message-ID: <1417815590.23238.11.camel@segulix>
References: <1417732931.20814.16.camel@segulix>
	 <1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	 <CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	 <1417798622.23238.6.camel@segulix>
	 <xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 22:40:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx0bc-0008N8-8J
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 22:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbaLEVj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 16:39:59 -0500
Received: from host1.easyho.st ([62.210.60.225]:43578 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbaLEVj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 16:39:59 -0500
Received: from [88.214.165.28] (port=22081 helo=[10.67.22.173])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1Xx0bS-003svW-B8; Fri, 05 Dec 2014 21:39:56 +0000
In-Reply-To: <xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host1.easyho.st
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - serjux.com
X-Get-Message-Sender-Via: host1.easyho.st: authenticated_id: sergio@serjux.com
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260896>

On Sex, 2014-12-05 at 10:30 -0800, Junio C Hamano wrote:
> Your promise is "these paths I will not modify" and in return you
> gain performance in "git status"

yeah  so  --assume-unchanged is for administrators of git , like I writ=
e
I change first  and --assume-unchanged after and never change it
again .=20
But if it is a tool for administration of git , I don't what to say ...
put it in a gitadmin command .=20

I hate git and this is one one the reason .=20

--=20
S=E9rgio M. B.
