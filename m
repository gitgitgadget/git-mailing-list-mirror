From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Mark gitk script executable
Date: Fri, 7 Jan 2011 15:35:04 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1101071526180.31807@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu> <7vlj2x8mr4.fsf@alter.siamese.dyndns.org> <20110107030119.GA32290@burratino> <7v4o9k7brc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:35:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbJ2K-0004gf-FR
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab1AGUfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 15:35:16 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:54628 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753565Ab1AGUfN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 15:35:13 -0500
X-AuditID: 1209190f-b7c1dae000000a2b-74-4d277900088d
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 6C.1E.02603.009772D4; Fri,  7 Jan 2011 15:35:12 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p07KZBBJ003842;
	Fri, 7 Jan 2011 15:35:11 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p07KZ9LC000176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 7 Jan 2011 15:35:10 -0500 (EST)
In-Reply-To: <7v4o9k7brc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164758>

On Fri, 7 Jan 2011, Junio C Hamano wrote:
> The change needs to come from gitk repository, so I'll leave it up to Paul
> ;-)

No, the script has always been executable in gitk.git.  The patch should 
be applied directly to git.git to bring the two repositories in sync.

Anders
