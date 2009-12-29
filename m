From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Wrap completions in `type git' conditional statement.
Date: Tue, 29 Dec 2009 20:05:30 +0900
Message-ID: <20091229200530.6117@nanako3.lavabit.com>
References: <44A6FDEB-71B6-42E1-99E3-D6A595FF1B58@metablu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sung Pae <sung@metablu.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 12:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPZtg-0001Wv-IW
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 12:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbZL2LFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 06:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZL2LFf
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 06:05:35 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39009 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbZL2LFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 06:05:34 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 87E8E11B8BA;
	Tue, 29 Dec 2009 05:05:34 -0600 (CST)
Received: from 4391.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id YOIR80J1BP7G; Tue, 29 Dec 2009 05:05:34 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=5MKJTE5mrw7OdBm8u/AutKQiJ3RuTROKDiw+gtnBUqmk30hCZrz6u+IqajeHN1iUDOJKobo0Tw9twn9FFCfKKUW05VLt8SVZGlve05lWe3eYyE8nvGcCCT27qFRo8sNIAceMpp9+T9ZYm09hfl2buaVnlJ0DU1Mt4rJDLo0xtJ8=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <44A6FDEB-71B6-42E1-99E3-D6A595FF1B58@metablu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135790>

Junio, could you tell us what happened to this thread?

The patch avoids failing completion script when git is not there.
No discussion.
