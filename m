From: Dannes Wessels <dizzzz@exist-db.org>
Subject: Re: git svn error "Not a valid object name"
Date: Sat, 16 Mar 2013 19:52:33 +0100
Message-ID: <84CAE079-7E2B-4F47-AC61-CED24D6C90A3@exist-db.org>
References: <CAJKLP9ZQBXf5ZZY9FccOAL5QU+q1b5SnAfvP9BpARdqvzPuWeg@mail.gmail.com> <20130316014548.GA16253@dcvr.yhbt.net> <CAJKLP9aX20i+oy7AMhh5+uAmP2Np4tUGTEvR+XDHyG1a_DSXtQ@mail.gmail.com> <20130316171354.GA2427@dcvr.yhbt.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Adam Retter <adam@exist-db.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dannes Wessels <dannes@exist-db.org>,
	Wolfgang Meier <wolfgang@exist-db.org>,
	=?utf-8?Q?Leif-J=C3=B6ran_Olsson?= <ljo@exist-db.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 16 19:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGwCh-0008D0-2x
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 19:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab3CPSvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 14:51:00 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38202 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3CPSu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 14:50:59 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so1508779wib.9
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 11:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to:x-gm-message-state;
        bh=m9RCml+4bFmIJ7ortpXvyqTJ2Xj7JEuX6VyBoMZqN3g=;
        b=Zm2hW9DdLsnbO2owShqU8dNX8xPi+UsKLNP/9iDp3tXrwXLnSiyUADrRw9b3FbgMfU
         o79WzPPe+s06toMRTzK0eUEwYt0OSRXWcxKm+piO3UuQdS9oBUHNaeZVrqcYWs+Y9E8S
         rvn7wDxvTAxKcVx81yJZ4WYRBMNBBk0JxKyzD+reqG3DYKwGDZDaeGsqpEXmTDnRwY0u
         08iz5iObMJSzO9+wkGaGiz3K1BnCJYhs3E4WST2OA+AY6qyBZtOJM7ryVYzJplGVh2Vs
         KS0/FHkOmYNPSfIDARPFe1GwpiQOp4uGzaAONXVvF1G2TPEWT770hFHb9LrgVdyrJST0
         TFfA==
X-Received: by 10.180.86.1 with SMTP id l1mr9149629wiz.32.1363459858249;
        Sat, 16 Mar 2013 11:50:58 -0700 (PDT)
Received: from ?IPv6:2002:d52e:c660::a02a:98ec:ecb4:6a9f? ([2002:d52e:c660:0:a02a:98ec:ecb4:6a9f])
        by mx.google.com with ESMTPS id j4sm4589766wiz.10.2013.03.16.11.50.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 11:50:57 -0700 (PDT)
In-Reply-To: <20130316171354.GA2427@dcvr.yhbt.net>
X-Mailer: iPhone Mail (10B146)
X-Gm-Message-State: ALoCoQmCz61KnKsM+ul5iibrQib1BbAJm4mCHz3tbeyEbeSs40Op3+Rd5GYfB+ghyRMj2AbE2Mxv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218312>

Http:// should provide access without password ......

--
Dannes Wessels

On 16 mrt. 2013, at 18:13, Eric Wong <normalperson@yhbt.net> wrote:

> Adam Retter <adam@exist-db.org> wrote:
>> If your able, any idea of when you might be able to take a look at the
>> bug? Our svn repo is publicly available for all.
> 
> svn ls https://svn.code.sf.net/p/exist/code/trunk
> ...Is asking me for username
