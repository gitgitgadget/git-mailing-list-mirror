From: Frans Pop <elendil@planet.nl>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 12:14:33 +0200
Message-ID: <200907281214.34362.elendil@planet.nl>
References: <200907280446.22890.elendil@planet.nl> <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVjhk-0004Tz-Ra
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 12:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbZG1KOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 06:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbZG1KOf
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 06:14:35 -0400
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:63050 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918AbZG1KOf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 06:14:35 -0400
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML107.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 28 Jul 2009 12:14:34 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com>
Content-Disposition: inline
X-OriginalArrivalTime: 28 Jul 2009 10:14:35.0107 (UTC) FILETIME=[34DA0B30:01CA0F6C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124231>

On Tuesday 28 July 2009, Erik Faye-Lund wrote:
> The problematic e-mails, are they coming from another user than you?
> Can you find out who that is, and check what git-version he or she
> runs?

The Message-Id in my mail was an actual example. Luckily a search for it 
gave the following link: http://patchwork.kernel.org/patch/37597/

See the link for the name of the user. The headers have:
   X-Mailer: git-send-email 1.5.2.5

Cheers,
FJP
