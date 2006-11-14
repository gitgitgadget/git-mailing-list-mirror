X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: =?ISO-8859-1?Q?Com=E8te?= <comete@archlinuxfr.org>
Subject: how to authenticate with git-svn on a subversion repository
Date: Tue, 14 Nov 2006 15:32:30 +0100
Message-ID: <4559D37E.1070703@archlinuxfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 02:28:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061108)
X-Ovh-Remote: 88.137.49.140 (88-137-49-140.adslgp.cegetel.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31405>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkAWE-0005Gy-BQ for gcvg-git@gmane.org; Wed, 15 Nov
 2006 03:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754376AbWKOC2v convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 21:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbWKOC2v
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 21:28:51 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:14536 "EHLO
 42.mail-out.ovh.net") by vger.kernel.org with ESMTP id S1754376AbWKOC2u
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 21:28:50 -0500
Received: (qmail 2053 invoked by uid 503); 14 Nov 2006 14:32:15 -0000
Received: from b6.ovh.net (HELO mail241.ha.ovh.net) (213.186.33.56) by
 42.mail-out.ovh.net with SMTP; 14 Nov 2006 14:32:15 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50) by b0.ovh.net with
 SMTP; 14 Nov 2006 14:31:46 -0000
Received: from 88-137-49-140.adslgp.cegetel.net (HELO ?192.168.5.10?)
 (morgan.lefieux%daknet.org@88.137.49.140) by ns0.ovh.net with SMTP; 14 Nov
 2006 14:31:45 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

hello !

i would like to use git-svn to commit some modifications to a Subversio=
n=20
repository but i don't know where i can enter my username and password=20
to commit to the repository ? Is there any special file to put them.
=46or now i get an error:

# git-svn commit remotes/git-svn
Autorisation refus=E9e: MKACTIVITY de=20
'/svn/!svn/act/8115f5df-c0da-4a6d-91ef-135dcb76141c': =C9chec =E0=20
l'autorisation (http://projet.archlinuxfr.org) at /usr/bin/git-svn line=
 553
512 at /usr/bin/git-svn line 574
	main::commit_lib('f45ba41060287fedfcedfb5fc4c29ecfe30a7466') called at=
=20
/usr/bin/git-svn line 480
	main::commit('remotes/git-svn') called at /usr/bin/git-svn line 172


Thanks

