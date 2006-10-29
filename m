X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 11:38:38 -0800 (PST)
Message-ID: <20061029193839.99122.qmail@web31802.mail.mud.yahoo.com>
References: <ei27mu$q9s$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 19:38:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DjgRQ1DMkGb8c9mZoB/Y3RmDyVVV/6ayUBhpghidzwJW5sh9y1LayGXNtovXXrO/2DDkzNWkVVAtp4BSs0I59ufq6RjXt7mOTHtO3pgcs+leagqQTm+0Ftd880A6LQ4Dv7QwxcJRhfMcBYP7SwMYBOItWnoEaeZBV/lh4BweYrs=  ;
X-YMail-OSG: duQeJO8VM1miJ2aI2dTeeh_O1Yt1CWjTKJZ48bLClvch6RTI.OJ.PumsjqcYURoQoQ--
In-Reply-To: <ei27mu$q9s$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30446>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGUV-0001eg-FK for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965344AbWJ2Tik (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965354AbWJ2Tik
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:38:40 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:13728 "HELO
 web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP id S965344AbWJ2Tij
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:38:39 -0500
Received: (qmail 99124 invoked by uid 60001); 29 Oct 2006 19:38:39 -0000
Received: from [71.80.233.118] by web31802.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 11:38:38 PST
To: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Anand Kumria <wildfire@progsoc.org> wrote:
> I think your version looks a lot nicer but I believe that the commit
> message area should be in a fixed-point font. In general it won't be a
> problem but if anyone should choose to insert a diagram or something else
> that assume a fixed-width display - it won't look good.

Thanks for catching this!

Jakub, I believe I submitted a patch to change that to fixed point
and you can see the reasons in the commit message.  See commit
4b7ce6e2d6ba088da50de1df38b040ea2c0b8f18.

Please change it to fixed point.

    Luben
