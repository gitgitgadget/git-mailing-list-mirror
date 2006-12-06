X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git newbie problems
Date: Wed, 06 Dec 2006 11:21:53 +0100
Message-ID: <457699C1.3060400@xs4all.nl>
References: <4574AC9E.3040506@gmail.com> <el55to$952$1@sea.gmane.org> <45768FE8.2030202@xs4all.nl> <200612061117.32903.jnareb@gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 10:21:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200612061117.32903.jnareb@gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33427>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtuO-00021m-VA for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760448AbWLFKVq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760450AbWLFKVq
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:21:46 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:3385 "EHLO
 smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760447AbWLFKVp (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 05:21:45 -0500
Received: from [192.168.0.103] (82-171-213-190.dsl.ip.tiscali.nl
 [82.171.213.190]) (authenticated bits=0) by smtp-vbr17.xs4all.nl
 (8.13.8/8.13.8) with ESMTP id kB6ALhpN061873 (version=TLSv1/SSLv3
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Wed, 6 Dec 2006 11:21:43 +0100
 (CET) (envelope-from hanwen@xs4all.nl)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:

> I don't know if git allows to pull into dirty tree with impunity. If I
> remeber correctly Cogito (alternate UI for git) allows this[*1*], there is
> currently work on this in git (but it is not as far as I remember in
> git 1.4.4.1). So another possibility is induced by CVS "update then commit"
> mentality pulling changes _before_ commiting changes.

it is quite possibly a side-effect of cvs-habits. Note that in the beginning
I have wrestled to make git update the HEAD , eg. trying --update-head-ok

-- 
