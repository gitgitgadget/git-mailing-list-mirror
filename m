From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Re: commit type
Date: Fri, 31 Oct 2008 16:56:05 -0200
Organization: DATACOM
Message-ID: <490B54C5.3070108@datacom.ind.br>
References: <loom.20081031T174821-603@post.gmane.org> <ee77f5c20810311104m6044bf70r1d9d405fa04454e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 7rans <transfire@gmail.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 19:57:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvzBa-0001zI-LF
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbYJaS4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbYJaS4I
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:56:08 -0400
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:44623 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751096AbYJaS4H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Oct 2008 14:56:07 -0400
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id 079EF32ADA; Fri, 31 Oct 2008 16:56:04 -0200 (BRST)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id 7A53F32AD8;
	Fri, 31 Oct 2008 16:56:04 -0200 (BRST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <ee77f5c20810311104m6044bf70r1d9d405fa04454e0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99621>

David Symonds wrote:
> On Fri, Oct 31, 2008 at 10:58 AM, 7rans <transfire@gmail.com> wrote:
> 
>> Currently I achieve this by adding "[type]" to the end of my commit messages.
>> But of course that's less than optimal.
> 
> Why is that less than optimal? It seems a lot less intrusive than what
> you suggest.
> 

Also, you can use a hook to check that the commit message contains a valid "type".

 - Samuel
