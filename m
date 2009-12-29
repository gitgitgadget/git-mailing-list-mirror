From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Allowing push --dry-run through fetch url
Date: Tue, 29 Dec 2009 20:05:17 +0900
Message-ID: <20091229200517.6117@nanako3.lavabit.com>
References: <20091106073707.GA14881@glandium.org> <7vfx8s0yy1.fsf@alter.siamese.dyndns.org> <20091106095357.GA13389@glandium.org> <7vfx8obz2o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 12:05:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPZtK-0001O2-D9
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 12:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbZL2LFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 06:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbZL2LFZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 06:05:25 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39000 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbZL2LFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 06:05:22 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 9A13611B8BB;
	Tue, 29 Dec 2009 05:05:22 -0600 (CST)
Received: from 4391.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id AA2H2OQH8RAC; Tue, 29 Dec 2009 05:05:22 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GEU3mHh7M2h3J9Sx66ACUODyhfM/yxwfvTP4Yju36uCEhvcK/2n5cIAPuM9DelN2RNpTrvmdMov1ngXOwuZOaAsT9/cHe9TDNYWEhPSyfhRgLzNdvUVcHdnxM7MvcsGHiW2uhRtA6kA+apq5T+Krlz1mvlSwuINZznU63c2EHBA=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <7vfx8obz2o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135786>

Junio, could you tell us what happened to this thread?

After discussing "git push --dry-run" that looks at URL used for
fetching, because pushURL might require authentication, the
maintainer recalls an earlier "git push --confirm" patch

http://thread.gmane.org/gmane.comp.version-control.git/128426/focus=128429

but nothing happens after that.
