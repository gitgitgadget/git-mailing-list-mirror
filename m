X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Sun, 19 Nov 2006 19:31:31 +0100
Message-ID: <200611191931.32193.jnareb@gmail.com>
References: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net> <ejpu4r$dsk$1@sea.gmane.org> <Pine.LNX.4.63.0611191729190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 18:30:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YOpkWZvXwtTqyA9XLjdPJ65/JPpCyb3bEaTQr0eeTogrButEfMJTkrQ5W7GIN/3LvYXPwTERo5ppZi+CYtTyLDaGR3Y4//MW/OFLtoN61Pij35p1oTn+Ih3H+H8nO2eTuiBPNgS98G/RH39LJgB9Medp8xkLvhyuvMQ9pnbogZc=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0611191729190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31849>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlrQk-0001fM-NJ for gcvg-git@gmane.org; Sun, 19 Nov
 2006 19:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932790AbWKSSaK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 13:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWKSSaK
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 13:30:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:18723 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932790AbWKSSaI
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 13:30:08 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1041976ugc for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 10:30:06 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr211179ugi.1163961006670; Sun, 19 Nov
 2006 10:30:06 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 5sm6550469ugc.2006.11.19.10.30.06; Sun, 19 Nov
 2006 10:30:06 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> I do not understand. What paths are handled by git-shortlog?

I was under (perhaps false) impression that somewhere in git-shortlog 
there is shortening of
  Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
messages, shortening the URL part.

Perhaps this was only other example of hard-coded git-for-Linux-ness.
-- 
Jakub Narebski
