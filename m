From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 10:35:25 +0100
Message-ID: <4BA9DCDD.6060109@viscovery.net>
References: <20100323232055.GV7038@pixar.com> <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Lars Damerow <lars@pixar.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 10:35:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuMzw-0003jo-Lr
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 10:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab0CXJfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 05:35:31 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58119 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755181Ab0CXJfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 05:35:30 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NuMzm-0000KL-9I; Wed, 24 Mar 2010 10:35:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 079EE1660F;
	Wed, 24 Mar 2010 10:35:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143079>

Am 3/24/2010 10:29, schrieb Alex Riesen:
> And while at it, how about making it a config option? (i.e. core.oneFilesystem?)

It's difficult to have this as a config option when you are looking for a
repository... ;)

-- Hannes
