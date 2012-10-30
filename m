From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Why does git-commit --template want the template to be modified
 ?
Date: Tue, 30 Oct 2012 12:14:28 +0100
Message-ID: <508FB694.10506@viscovery.net>
References: <CAC9WiBjeuy8dpSnp5Jq55hs1-CJUzwpH70GZ1ZGOF2dAAeypaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 12:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT9mQ-0002ow-CY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 12:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649Ab2J3LOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 07:14:34 -0400
Received: from so.liwest.at ([212.33.55.24]:5880 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab2J3LOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 07:14:34 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TT9m9-0005Cb-5j; Tue, 30 Oct 2012 12:14:29 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AFD191660F;
	Tue, 30 Oct 2012 12:14:28 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CAC9WiBjeuy8dpSnp5Jq55hs1-CJUzwpH70GZ1ZGOF2dAAeypaw@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208698>

Am 10/30/2012 11:53, schrieb Francis Moreau:
> I'm using git-commit with the --template option. The template I'm
> given is self sufficient for my purpose but as stated in the
> documentation, git-commit wants the template to be edited otherwise it
> aborts the operation.
> 
> Is it possible to change this ?

Perhaps you wanted to use --file instead of --template?

-- Hannes
