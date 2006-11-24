X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ignacio Arenaza <iarenuno@eteo.mondragon.edu>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method 
	HTTP/1.x  proxying
Date: Fri, 24 Nov 2006 09:46:04 +0100
Message-ID: <67mz6h6xmb.fsf@poseidon.eteo.mondragon.edu>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu><7v64
	d5keke.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 24 Nov 2006 08:46:18 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v64d5keke.fsf@assigned-by-dhcp.cox.net> (Junio C. 
	Hamano'smessage of "Thu, 23 Nov 2006 14:01:37 -0800")
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.4 (gnu/linux)
X-imss-version: 2.044
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32197>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWhK-0007bV-Gj for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934496AbWKXIqL convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006 03:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934502AbWKXIqL
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:46:11 -0500
Received: from mx.eteo.mondragon.edu ([193.146.78.131]:31960 "EHLO
 mx.eteo.mondragon.edu") by vger.kernel.org with ESMTP id S934496AbWKXIqJ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:46:09 -0500
Received: by mx.eteo.mondragon.edu (Postfix, from userid 1001) id 85B6EB6B2;
 Fri, 24 Nov 2006 09:46:08 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (poseidon.eteo.mondragon.edu
 [172.31.3.4]) by mx.eteo.mondragon.edu (Postfix) with ESMTP id C25FAB6B1;
 Fri, 24 Nov 2006 09:46:04 +0100 (CET)
Received: from poseidon.eteo.mondragon.edu (localhost [127.0.0.1]) by
 localhost.eteo.mondragon.edu (Postfix) with ESMTP id 9E24D2FD65; Fri, 24 Nov
 2006 09:46:04 +0100 (CET)
Received: by poseidon.eteo.mondragon.edu (Postfix, from userid 1072)id 
 8DF332FD15; Fri, 24 Nov 2006 09:46:04 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Also it has a style inconsistency between "if(expression) {" and
> "if(expression){", and I do not like either of them, but fixing
> that should be left to a separate patch.

I just tried to use the formating of the existing code, but
it seems I missed some lines. Will send a new patch with all the
comments made so far in a few hours.

Saludos. I=F1aki.

--=20
School of Management
Mondragon University
20560 O=F1ati - Spain
+34 943 718009 (ext. 225)

