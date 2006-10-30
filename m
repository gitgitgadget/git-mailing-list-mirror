X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 14:40:28 -0800 (PST)
Message-ID: <578323.77588.qm@web31809.mail.mud.yahoo.com>
References: <200610302250.06733.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 22:40:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=BJst4nXSazjvxZXM1FHnNJHHgs+gNtxVlroUDvwCG/yJwCQZ5Vd0gG5lDGGx+OpyCsMmxUiEV5v5VcR3dIh1O7yL8eTX1MpP6R3wKWcalGwAzyJQI6gB991hmVr+xgNgXW/ojtBBEj8b3+UyeuSyhT1j4VSBu/zisTgmelKK/80=  ;
X-YMail-OSG: yrgK49wVM1keN3gZX68E1zA2z.F2OJh.MNJHojnJRgvDFpn4gFPmcp7K5v1AGjH2ignEcqaT7MmB6Uk.LBSAu.UzZE1KhkilVcGH8QCMrFTuoHaTIvn8HBpgppmx5p1PHtxaOxiaSTo-
In-Reply-To: <200610302250.06733.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30542>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gefo4-0004lk-98 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422718AbWJ3Wkc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWJ3Wkc
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:40:32 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:10923 "HELO
 web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1422722AbWJ3Wkb (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006
 17:40:31 -0500
Received: (qmail 78745 invoked by uid 60001); 30 Oct 2006 22:40:28 -0000
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Mon,
 30 Oct 2006 14:40:28 PST
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> I'm just saying that with HTML diffs, presented via gitweb in graphical
> web browser, you have more possibilities, more formatting to use.
> Why not make use of it?

That sounds fine.

The question is where one draws the line.

> >> BTW. you can easily override it in your CSS file.
> > 
> > Why should we allow something to go into gitweb and disrupt the current
> > default behavior only so that people have to change their own css file
> > to keep current default behaviour.  Please don't shove this down our
> > throats.  Please?
> 
> That was just to note that if you don't agree with default, you can change
> it very easily. It is probably the time where people would disagree (for
> example infamous "redundant links" debate) on the gitweb UI; the possibility
> to tailor it easily to your own UI concepts and ideas is in my opinion
> very important (and very nice).

I would like to keep the visual default as stable as possible.

   Luben
