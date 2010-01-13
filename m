From: "Edward Z. Yang" <ezyang@MIT.EDU>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 15:13:35 -0500
Message-ID: <1263413564-sup-6775@ezyang>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:13:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9bG-0006S3-5O
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab0AMUNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945Ab0AMUNt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:13:49 -0500
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:57450 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753632Ab0AMUNt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 15:13:49 -0500
X-AuditID: 12074422-b7b85ae000000733-16-4b4e297c4287
Received: from grand-central-station.mit.edu (GRAND-CENTRAL-STATION.MIT.EDU [18.7.21.82])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id D5.61.01843.C792E4B4; Wed, 13 Jan 2010 15:13:48 -0500 (EST)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by grand-central-station.mit.edu (8.13.6/8.9.2) with ESMTP id o0DKE4oq016252;
	Wed, 13 Jan 2010 15:14:06 -0500 (EST)
Received: from localhost (EZYANG.MIT.EDU [18.243.1.50])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id o0DKDp1Q003791;
	Wed, 13 Jan 2010 15:13:57 -0500 (EST)
In-reply-to: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Sup/git
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAAQCq+Kk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136872>

Excerpts from Ilari Liusvaara's message of Wed Jan 13 08:19:44 -0500 2010:
> Supported authentication mechanisms include passwords, keypairs and on
> some platforms Unix authentication if using unix domain sockets. Server
> is authenticated using keypair (hostkey).

As a Git user, I'd like to say: it's about damn time! :-)

Cheers,
Edward
