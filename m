From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] config: add --repository option
Date: Tue, 02 Jun 2009 19:55:55 +0900
Message-ID: <20090602195555.6117@nanako3.lavabit.com>
References: <1241886936-18941-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 12:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBRfE-00066X-Oz
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 12:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbZFBK4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 06:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbZFBK4H
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 06:56:07 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35038 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbZFBK4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 06:56:06 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id BB10F11B890;
	Tue,  2 Jun 2009 05:56:08 -0500 (CDT)
Received: from 4886.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id NDPAOMDDD08D; Tue, 02 Jun 2009 05:56:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=EEnuBST62Ko0a2iRbT1AzhpKD8s8rFehnYGS8qGGajiw6s3QzeIjjLNU7fT3k5b5GKbm9z4CIpzr2i1+BKBFI67jqYXOo8ssWcTjz72k4N2LBUVdXZOFAVCU0kNviVwIwcy5HMggWLDdW0bYrLiHxrVUb9f1K63k9nXVfB/rDZA=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1241886936-18941-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120502>

Quoting Sverre Rabbelier <srabbelier@gmail.com>:

> This is a shorthand similar to --system but instead uses
> the config file of the current repository.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
> 	I often want to check what the local value of a config
> 	entry is, hence this patch.
>
>  builtin-config.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

Junio, may I ask what happened to this patch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
