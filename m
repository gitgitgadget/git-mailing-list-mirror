X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: tracking separate branches with RSS
Date: Tue, 14 Nov 2006 02:50:36 +0100
Message-ID: <455920EC.7060804@xs4all.nl>
References: <ejb3hh$nvr$1@sea.gmane.org> <ejb410$nvg$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 01:58:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <ejb410$nvg$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31332>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjnX4-0001dX-8m for gcvg-git@gmane.org; Tue, 14 Nov
 2006 02:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755387AbWKNB4L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 20:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbWKNB4L
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 20:56:11 -0500
Received: from main.gmane.org ([80.91.229.2]:63711 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755387AbWKNB4J (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 20:56:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GjnUm-00012U-3Y for git@vger.kernel.org; Tue, 14 Nov 2006 02:53:55 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Tue, 14 Nov 2006 02:53:52 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 14 Nov 2006 02:53:52
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:

>> A second possibility -less desirable, but better than nothing- is to 
>> have commits from all branches show up in the shortlog and the RSS feed.
> 
> Use "--all" as 'h' (hash) parameter.
> 

This doesn't seem to work.  Note that I'm savannah.gnu.org, which may 
run an older version. The quickest way to get this up and running is to 
have real patches appear in the official release, and convince Sylvain 
to upgrade to a better gitweb.

> P.S. What do you think about moving from RSS to Atom for feeds?

I don't know: as far as I'm concerned, both are things that I paste into 
Thunderbird's "News & Blog" section, and then it magically works. (or 
doesn't, as in this case).


-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
