From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 14:03:34 +0100
Message-ID: <51486226.90203@ira.uka.de>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com> <20130318170804.GA15924@sigill.intra.peff.net> <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com> <CALkWK0nhmks6LqoALA8hrwkR00NjweyqV2RJ9-9V3q-bjgpsCg@mail.gmail.com> <CACsJy8D10yXoxynOscWjCyAq8qxeXOCMJLqkFYzSRUokUgYF8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 14:03:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHwCl-0004PT-QV
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 14:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab3CSNDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 09:03:24 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52166 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754648Ab3CSNDY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 09:03:24 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1UHwC9-0006RU-PT; Tue, 19 Mar 2013 14:03:20 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1UHwC8-0003ei-4o; Tue, 19 Mar 2013 14:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <CACsJy8D10yXoxynOscWjCyAq8qxeXOCMJLqkFYzSRUokUgYF8A@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1363698200.498791000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218511>

Would it make sense to allow abbreviation similar to how git objects can 
be abbreviated? This would mean origin usually could be spelled just o
