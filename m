X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 14:11:53 +0100
Message-ID: <455C6399.5020407@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>	<87hcx1u934.wl%cworth@cworth.org>	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>	<455BBCE9.4050503@xs4all.nl>	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>	<455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net> <455C618A.7080309@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 13:12:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <455C618A.7080309@xs4all.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31580>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkh2s-0003Mg-Tl for gcvg-git@gmane.org; Thu, 16 Nov
 2006 14:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424022AbWKPNMd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 08:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424023AbWKPNMd
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 08:12:33 -0500
Received: from main.gmane.org ([80.91.229.2]:33938 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1424022AbWKPNMc (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 08:12:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gkh2O-0003HG-LO for git@vger.kernel.org; Thu, 16 Nov 2006 14:12:16 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 16 Nov 2006 14:12:16 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006 14:12:16
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys escreveu:

> I can go on with listing idiosyncrasies, but my point is not to get help 
> from you, but rather to show how git can be improved.

oh, and another annoying one: git's insistence on firing up a pager if 
there is nothing to page, eg. try

   git-log je-n-existe-pas

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
