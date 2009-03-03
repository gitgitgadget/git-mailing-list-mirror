From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: fatal: git write-tree failed to write a tree
Date: Tue, 3 Mar 2009 00:47:41 -0500
Message-ID: <81bfc67a0903022147m42e8fe38gb93773084614d30@mail.gmail.com>
References: <81bfc67a0902280825t507e385bvd25c846add2a299c@mail.gmail.com>
	 <alpine.DEB.1.00.0903012210230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 06:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeNVC-0006pq-5w
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 06:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbZCCFrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 00:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbZCCFrr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 00:47:47 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:27177 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZCCFrq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 00:47:46 -0500
Received: by qw-out-2122.google.com with SMTP id 5so4023262qwi.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 21:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7ozJjdFXyYo3OAswLiT07WxODTxVYuXV8IFAOvIkuEY=;
        b=UusAF1OsoQ8iO0T6wYGnl9BD/yAXRHJHioZyw1FYqBhUaVasM9Ac6vMc9qBuQJI4P/
         QOUIUT5yQcampSuWCkIthd41uX6+KHKGNI9u613rSyf8SPE5BIRWj0ODIy+J34JEQbi6
         2ABlgdifNf5Rj8efqAJJ8SHfra5hXE5wK2FYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HR5wq2NI3tbYvr9pbufdRXp9sdV7EPPidNTJZiHFxnmtytv4rjDDqDDnxkl1A4eyu6
         ovVpMX82i5KzOpZGKfO7DxSZIAH5et6tsWvPlqDN+qT4b24lRSenCNZpHg46zAZAdRqE
         Nl7PDPLC0lYzrURKRecAxBlRQsPx2eE9iwg78=
Received: by 10.229.81.129 with SMTP id x1mr3696458qck.16.1236059264156; Mon, 
	02 Mar 2009 21:47:44 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903012210230.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112000>

On Sun, Mar 1, 2009 at 4:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> A tree cannot contain unmerged files.


so... still looking for a solution since it seems I can no longer do a
merge from this remote. There has to be a way to get the tree back
into a proper state...
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
