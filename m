From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] git-completion: Add support for git submodule options
Date: Mon, 11 Apr 2011 19:59:54 +0200
Message-ID: <4DA3419A.4080809@web.de>
References: <4DA33EC8.5040704@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:00:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LP6-0002VZ-Gn
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab1DKR74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 13:59:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:37373 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab1DKR74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 13:59:56 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9D1AE18B4DB78;
	Mon, 11 Apr 2011 19:59:54 +0200 (CEST)
Received: from [93.240.123.81] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q9LP0-0001kR-00; Mon, 11 Apr 2011 19:59:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <4DA33EC8.5040704@morey-chaisemartin.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19n64IbieBWsRIKRAcG2aj+g90Xfqb6zxVywMnv
	OO0v5nrBenuCFfg1ZB8BYOzBVR/3O0xi0hVIX6qmQyA3n7n/z6
	rwm6gGIGAt/IZqXuzW+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171341>

Am 11.04.2011 19:47, schrieb Nicolas Morey-Chaisemartin:
> Completion for git submodule only handled subcommands.
> Add support for options of each subcommand
> 
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>

I don't know much about the internals of completion, but I like where
this is heading.
