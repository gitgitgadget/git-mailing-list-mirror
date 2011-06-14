From: Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>
Subject: RE: Objects deleted before first commit
Date: Tue, 14 Jun 2011 13:00:12 +0000
Message-ID: <8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
 <BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 15:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWTED-0000WE-PO
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 15:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab1FNNAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 09:00:16 -0400
Received: from webmail.gottexbrokers.com ([212.203.71.151]:29211 "EHLO
	Edge.gottexbrokers.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab1FNNAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 09:00:15 -0400
Received: from exchange.GottexBrokers.local (212.203.71.150) by
 Edge.gottexbrokers.com (212.203.71.151) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Tue, 14 Jun 2011 15:00:13 +0200
Received: from exchange.GottexBrokers.local ([fe80::2516:9680:eb73:c7b9]) by
 exchange.GottexBrokers.local ([fe80::2516:9680:eb73:c7b9%12]) with mapi id
 14.01.0218.012; Tue, 14 Jun 2011 15:00:13 +0200
Thread-Topic: Objects deleted before first commit
Thread-Index: Acwqj7T+SjxTfmyrQwaDHlzYRmVyZAAANDGQ///ixwD//95WEA==
In-Reply-To: <BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.11.12.203]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175767>

In fact I have some folders and files there, but I have no idea on how to restore them into "Real Files". I am using windows 7 unluckily, but I have managed to find the files. This is an extract of my git fsck:


dangling blob 43cb00bb9f23b73afc874c4105b136f8c426e4a5
dangling blob 48ef642adb1549ee1d4040ec9337d3a47c19d422
dangling blob 4cf3c37ee29d1ceac9959e9dabde5f32eba8bc14
dangling blob 4ff7172c54e1f67e8c5a8ac6f49d2ede702747e7
dangling blob 51a746ceede3b0c61f4f7decd63d78c40c4772e8
dangling blob 53a30509175c31e651605d40e0bb8285eeffd67c
dangling blob 5877a2433fc2cc384bafb9bfca545ce6880b88d7
dangling blob 59137f1fd4c8905ebc316f7113392d01d91b37c1
dangling blob 5bdf3d9fd6ccc47eae53ef69d63e3852b5c95975
dangling blob 5f6327c2b506813f442cde76da067bf44f5a7ff6
dangling blob 5fefe72c7737c47fc1ab46e18d42138b9a962b59
dangling blob 6423072e9d2ba825b41183b8d061026580185938
dangling blob 68cbb38aec908417c4cefb9a15cb27b5763fa598
dangling blob 717f2a64ef775eb71b1cef4870dded92c5cde838
dangling blob 721743d1c61727b77df083b5f06d8cea4fbc85a7
dangling blob 7323efecc86ac03037f17925c2fd981921f969fa
dangling blob 77c79b12b01567f2e4e78c60a5168d6d60e51787
dangling blob 7daf896d97fd796c0a8e8093ba426bf488e3567b
dangling blob 7eabf5e3d2bc12df57af9b640cf864070fc589f7
dangling blob 83c3ba571822b67359a0573ebb1aaf1edbf66110
dangling blob 83cf30ac74d4b56953db017bd0793ee4cd5579d7
dangling blob 87733108c9d6a268da34c10f4defc1b7bb92ba02
dangling blob 8abf694b11a2cf34b5c3e21057542992f1efce9b
dangling blob 8cc3fad8d0ea8a6daf8f7e3fc6bcf6cedcbd92cc
dangling blob 8f3b009a1a384cd4e71589b85b353c1d6eb721b7
dangling blob 9087db2d16660e0fa83bc9d3c64bd01e21807d61
dangling blob 90c39a97d03e22a9318a2e14c363388ac342faa9
dangling blob 91834d9a142c874cc32ec267c7582066c36ef184
dangling blob 921372d4d6d7480b8412e8fc6c7874c11235b804
dangling blob 92a73995eb057fd8bf6004255862eb022fc9e34f
dangling blob 94177daa77f896aba7a48a8b4daaa984ebc004c3
dangling blob 9483128d060cd6d99f4e29df3ccfd479b771abcb
dangling blob 968b4f44763ba93aba1b2fc20cc081b7f01db316
dangling blob 995f114e2eb864920576bbd63f46bb05dc3ede6f
dangling blob 9c7b8dedb2682badabbdaa61bbe944a0190e49e6
dangling blob 9d0bcc97d6e0fa9119ec266bb4d7f741dad0e452
dangling blob 9dbbd4aa5a8b4a409561e3ed5eb5102e12627cce
dangling blob acc38a42f10e6c022d655f1eac3358fcb86c0605
dangling blob b01b840d2522b80b5aa47c0a9caf266943b4cc9a
dangling blob b3a3303f00c61133b9b287b41310a0573b31e5bb
dangling blob b7438803f774b309833046b471b66194cb0e297f
dangling blob b89b84baacb432b04733449da40e7b2b2b439f03
dangling blob bf33ef8cd1beadfc7a6b22ff3d55ee4b2294ae48
dangling blob c57f6f8c5406a5d8c53114a6d7c9f82e790e9969
dangling blob d06332575bf4c46469b8bedfd18c69cb4653095c
dangling blob d49ba81f960dc8abf1892573515f4a5231405125
dangling blob d66ba089f65c99cc06807fe690840d7a8302105b
dangling blob d70f55535e3bf326f78ebb162fb7ee13b9603746
dangling blob da1f11eedf8cbc532f4aad7d0686415190e1fe97
dangling blob ddbb9c6af5a001d7e0ab6ddf993f5a7f7ce8d864
dangling blob e1834e238ff682a9606822bd943ed872ffb93da9
dangling blob e19f3a0b3dec6534ec20015bc616e291444493d0
dangling blob e373dca971b1fd5223e40de3b70cf2977bde1e06
dangling blob e74fe9499028597a30a77517601c49d59ac41a69
dangling blob e77b60f836331e54a3f4059d9d1c2e486e37b831
dangling blob eb2f8dcb9488d9f3483c094083df4673b9c4b35d
dangling blob ef5794b3373cb14c90ffd83f3b3ff2d98b780b43
dangling blob fa8b75106f0bc76edd4961588480653e053881f0
dangling blob fd33afe21d6abb02677310d32c9362ef6a18287e


Edmondo Porcu
Financial  software architect



Avenue de Rhodanie 48
1007 Lausanne
Switzerland.

Dir  +41 (0) 21  560 30 82
Fax +41 (0) 21  617 71 55
Email : edmondo.porcu@gottexbrokers.com

The information in this email is confidential and may be legally privileged. If you are not the intended recipient, you must not read, use or disseminate the information. Although this email and any attachments are believed to be free of any virus or other defect that might affect any computer system into which it is received and opened, it is the responsibility of the recipient to ensure that it is virus free and no responsibility is accepted by the Gottex Group of Companies for any loss or damage arising in any way from its use.


-----Original Message-----
From: David Barr [mailto:davidbarr@google.com] 
Sent: mardi 14 juin 2011 14:58
To: Edmondo Porcu
Cc: git@vger.kernel.org
Subject: Re: Objects deleted before first commit

On Tue, Jun 14, 2011 at 10:43 PM, Edmondo Porcu
<Edmondo.Porcu@gottexbrokers.com> wrote:
> I have created a git repository, and then I have deleted by error some files with rm -rf .
> Now the files have disappeared from the hard disk, I am desperately looking on how to restore them. The objects folder is full of dangling objects, but I do not know how to recover them.

If you did use 'git add' to stage your work before the unfortunate
invocation of rm, the blobs should be accessible.

Something like the following might work:
git show `cd .git/objects; ls ??/* | tr -d /`

This will pretty print all loose objects.
--
David Barr.

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
