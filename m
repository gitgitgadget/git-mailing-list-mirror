From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 19:20:42 +0900
Message-ID: <20080720192042.6117@nanako3.lavabit.com>
References: <alpine.DEB.1.00.0807181356010.3932@eeepc-johanness>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 12:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKW3Z-0001gh-0N
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbYGTKVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbYGTKVO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:21:14 -0400
Received: from karen.lavabit.com ([72.249.41.33]:48303 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbYGTKVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:21:14 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id A68D3C88E0;
	Sun, 20 Jul 2008 05:21:04 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id ZF2DYTC28UF3; Sun, 20 Jul 2008 05:21:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=qB7q7gRVwmfozh8j8LFS7I3QOsm3ESHnJfZeQal3YqatCT6YKVWjqKVvreVeD9bmmowhQQuNmSNfnLqY49Sa3n+gDO0ivjwFjldPNwf5AO0jhQ75wlxrcG1A6v1dAae6VBYg7yFgVbu2qlk07iQf4RvbH+wyw6OXIgdmzJkWoF4=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>;
In-Reply-To: <alpine.DEB.1.00.0807181356010.3932@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89175>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> On Fri, 18 Jul 2008, Nanako Shiraishi wrote:
>
>> Quoting Junio C Hamano <gitster@pobox.com>:
>> > This needs to be merged to master iff/when merge-theirs gets merged, 
>> > but I do not think this series is widely supported, so both are on 
>> > hold.
>> 
>> Why do you say it is not widely supported?  I may be wrong but I think 
>> you developed these patches after somebody from the mailing list asked 
>> for this feature.
>
> Asking for a feature, and then not doing a single thing to defend why it 
> makes sense, of a single person, who does not even speak up now, does not 
> count for "wide support".

For the record, I was not the one who asked for such a feature.

It seems that the conclusion of the discussion is that "theirs" promotes a bad workflow, and I am happy with that.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
