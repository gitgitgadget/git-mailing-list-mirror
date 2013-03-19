From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 12:58:15 +0100
Message-ID: <514852D7.9080607@ira.uka.de>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com> <20130318170804.GA15924@sigill.intra.peff.net> <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 12:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHvBU-0006zx-Un
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 12:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab3CSL6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 07:58:00 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49498 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071Ab3CSL6A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 07:58:00 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UHvAv-0000jL-Dd; Tue, 19 Mar 2013 12:57:58 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UHvAv-0005Jg-4j; Tue, 19 Mar 2013 12:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1363694278.628045000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218507>

Am 19.03.2013 12:33, schrieb Duy Nguyen:
> git push . foo:bar

'.' has more like a "here" semantic, '..' might be a more fitting 
mnemonic here.
